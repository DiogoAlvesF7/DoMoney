import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class GraficoDespesas extends StatefulWidget {
  @override
  _GraficoDespesasState createState() => _GraficoDespesasState();
}

class _GraficoDespesasState extends State<GraficoDespesas>
    with SingleTickerProviderStateMixin {
  final Map<String, double> segmentos = {
    "Alimentação": 80.0,
    "Transporte": 50.0,
    "Saúde": 100.0,
    "Educação": 40.0,
    "Lazer": 30.0,
  };

  String? _segmentoSelecionado;
  double? _valorSegmentoSelecionado;
  late AnimationController _animationController;
  bool _listaExpandida = false;
  final Map<String, List<Map<String, dynamic>>> _gastos = {
    "Alimentação": [
      {
        "titulo": "Supermercado",
        "data": "01/10/2023",
        "descricao": "Compra mensal",
        "valor": 50.0
      },
      {
        "titulo": "Restaurante",
        "data": "05/10/2023",
        "descricao": "Almoço",
        "valor": 30.0
      },
    ],
    "Transporte": [
      {
        "titulo": "Combustível",
        "data": "03/10/2023",
        "descricao": "Gasolina",
        "valor": 50.0
      },
    ],
    "Saúde": [
      {
        "titulo": "Farmácia",
        "data": "02/10/2023",
        "descricao": "Medicamentos",
        "valor": 100.0
      },
    ],
    "Educação": [
      {
        "titulo": "Curso",
        "data": "04/10/2023",
        "descricao": "Curso online",
        "valor": 40.0
      },
    ],
    "Lazer": [
      {
        "titulo": "Cinema",
        "data": "06/10/2023",
        "descricao": "Filme",
        "valor": 30.0
      },
    ],
  };

  void _atualizarValorSegmento(String segmento) {
    final novoValor = _gastos[segmento]!.fold<double>(
      0.0,
      (sum, item) => sum + item['valor'],
    );

    setState(() {
      segmentos[segmento] = novoValor;
    });
  }

  void _removerSegmento(String segmento) {
    setState(() {
      segmentos.remove(segmento);
      _gastos.remove(segmento);
      _segmentoSelecionado = null; // Limpa seleção após remoção
      _valorSegmentoSelecionado = null;
    });
  }

  void _adicionarSegmento() {
    String? novoNome;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Adicionar Segmento"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Campo para nome do segmento
              TextField(
                decoration:
                    const InputDecoration(labelText: "Nome do Segmento"),
                onChanged: (value) {
                  novoNome = value.trim();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                if (novoNome != null && novoNome!.isNotEmpty) {
                  if (segmentos.containsKey(novoNome)) {
                    // Nome já existe
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Esse segmento já existe."),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    // Adiciona o novo segmento
                    setState(() {
                      segmentos[novoNome!] = 0.0; // Inicializa com valor 0
                      _gastos[novoNome!] = []; // Cria uma lista vazia
                    });
                    Navigator.of(context).pop();
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("O nome do segmento não pode estar vazio."),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text("Salvar"),
            ),
          ],
        );
      },
    );
  }

  void _adicionarItem(String segmento) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController tituloController = TextEditingController();
        final TextEditingController descricaoController =
            TextEditingController();
        final TextEditingController valorController = TextEditingController();
        final TextEditingController dataController = TextEditingController();

        return AlertDialog(
          title: const Text("Adicionar Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tituloController,
                decoration: const InputDecoration(labelText: "Título"),
              ),
              TextField(
                controller: descricaoController,
                decoration: const InputDecoration(labelText: "Descrição"),
              ),
              TextField(
                controller: valorController,
                decoration: const InputDecoration(labelText: "Valor"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: dataController,
                decoration: const InputDecoration(labelText: "Data"),
                keyboardType: TextInputType.datetime,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                final String titulo = tituloController.text;
                final String descricao = descricaoController.text;
                final double valor =
                    double.tryParse(valorController.text) ?? 0.0;
                final String data = dataController.text;

                setState(() {
                  // Adiciona o item ao segmento
                  _gastos[segmento]?.add({
                    "titulo": titulo,
                    "descricao": descricao,
                    "valor": valor,
                    "data": data,
                  });

                  // Atualiza o valor do segmento
                  _atualizarValorSegmento(segmento);
                });

                Navigator.pop(context);
              },
              child: const Text("Salvar"),
            ),
          ],
        );
      },
    );
  }

  void _editarItem(String segmento, int index) {
    final item = _gastos[segmento]![index];

    final TextEditingController tituloController =
        TextEditingController(text: item['titulo']);
    final TextEditingController descricaoController =
        TextEditingController(text: item['descricao']);
    final TextEditingController valorController =
        TextEditingController(text: item['valor'].toString());
    final TextEditingController dataController =
        TextEditingController(text: item['data']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Editar Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tituloController,
                decoration: const InputDecoration(labelText: "Título"),
              ),
              TextField(
                controller: descricaoController,
                decoration: const InputDecoration(labelText: "Descrição"),
              ),
              TextField(
                controller: valorController,
                decoration: const InputDecoration(labelText: "Valor"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: dataController,
                decoration: const InputDecoration(labelText: "Data"),
                keyboardType: TextInputType.datetime,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Atualiza os valores do item
                  item['titulo'] = tituloController.text;
                  item['descricao'] = descricaoController.text;
                  item['valor'] = double.tryParse(valorController.text) ?? 0.0;
                  item['data'] = dataController.text;

                  // Atualiza o valor do segmento
                  _atualizarValorSegmento(segmento);
                });

                Navigator.pop(context);
              },
              child: const Text("Salvar"),
            ),
          ],
        );
      },
    );
  }

  void _removerItem(String segmento, int index) {
    setState(() {
      _gastos[segmento]?.removeAt(index);

      // Atualiza o valor do segmento
      _atualizarValorSegmento(segmento);
    });
  }

  double get _valorTotal {
    return segmentos.values.fold(0.0, (sum, value) => sum + value);
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double total = segmentos.values.reduce((a, b) => a + b);
    const double centerRadius = 75.0; // Vão central mais destacado
    const double sliceRadius = 45.0; // Casca mais fina

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Valor total das despesas no topo
                Text(
                  "Total: R\$ ${_valorTotal.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Botão Adicionar Segmento (somente ícone)
                    IconButton(
                      onPressed: () {
                        _adicionarSegmento();
                      },
                      icon: const Icon(Icons.add_circle,
                          size: 24, color: Colors.green),
                      tooltip: "Adicionar Segmento",
                    ),
                    const SizedBox(width: 1), // Espaço entre os botões

                    // Botão Remover Segmento (somente ícone)
                    IconButton(
                      onPressed: _segmentoSelecionado != null
                          ? () {
                              _removerSegmento(_segmentoSelecionado!);
                            }
                          : null, // Desativa se nenhum segmento estiver selecionado
                      icon: Icon(
                        Icons.remove_circle,
                        size: 24,
                        color: _segmentoSelecionado != null
                            ? Colors.red
                            : Colors.grey,
                      ),
                      tooltip: "Remover Segmento",
                    ),
                  ],
                ),
                // Gráfico de setores com tamanho fixo
                SizedBox(
                  height:
                      250, // Define um tamanho fixo para evitar erro de layout
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(
                          centerSpaceRadius:
                              centerRadius, // Espaço vazio no meio
                          sectionsSpace: 4, // Espaço entre os segmentos
                          sections: segmentos.entries.map((entry) {
                            final isSelected =
                                _segmentoSelecionado == entry.key;

                            // Valor mínimo para segmentos com valor 0
                            final displayValue =
                                entry.value == 0 ? 10 : entry.value;

                            return PieChartSectionData(
                              color: isSelected
                                  ? Colors.red[700]
                                  : Colors.red[300],
                              value: displayValue.toDouble(),
                              title:
                                  "${((entry.value / total) * 100).toStringAsFixed(1)}%",
                              radius:
                                  isSelected ? sliceRadius + 10 : sliceRadius,
                              titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            );
                          }).toList(),
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              if (event is FlTapUpEvent &&
                                  pieTouchResponse?.touchedSection != null) {
                                final touchedIndex = pieTouchResponse!
                                    .touchedSection!.touchedSectionIndex;

                                setState(() {
                                  if (touchedIndex >= 0) {
                                    if (_segmentoSelecionado ==
                                        segmentos.keys
                                            .elementAt(touchedIndex)) {
                                      // Desseleciona se clicar no mesmo segmento
                                      _segmentoSelecionado = null;
                                      _valorSegmentoSelecionado = null;
                                    } else {
                                      // Seleciona o novo segmento
                                      _segmentoSelecionado = segmentos.keys
                                          .elementAt(touchedIndex);
                                      _valorSegmentoSelecionado = segmentos
                                          .values
                                          .elementAt(touchedIndex);
                                    }
                                  }
                                });
                              }
                            },
                          ),
                        ),
                      ),

                      // Valor no centro do gráfico
                      GestureDetector(
                        onTap: () {
                          // Lógica para ignorar o clique no centro
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Selecione um segmento!"),
                            ),
                          );
                        },
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _segmentoSelecionado ?? "Clique no gráfico",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (_segmentoSelecionado != null)
                                  Text(
                                    "Total: R\$ ${_valorSegmentoSelecionado?.toStringAsFixed(2) ?? "0.00"}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _listaExpandida = !_listaExpandida;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 24),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: _listaExpandida
                          ? Colors.red.shade800
                          : Colors.red.shade800,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _listaExpandida ? 'Ver menos' : 'Ver mais',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        AnimatedRotation(
                          turns: _listaExpandida
                              ? 0.5
                              : 0, // Gira o ícone suavemente
                          duration: const Duration(milliseconds: 300),
                          child: Icon(
                            _listaExpandida
                                ? Icons.expand_less
                                : Icons.expand_more,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Lista de Gastos
                if (_listaExpandida && _segmentoSelecionado != null) ...[
                  ElevatedButton.icon(
                    onPressed: _segmentoSelecionado != null
                        ? () => _adicionarItem(_segmentoSelecionado!)
                        : null, // Habilita somente se um segmento estiver selecionado
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text("Adicionar Item"),
                  ),
                  ListView.builder(
                    shrinkWrap: true, // Permite rolagem dentro da Column
                    physics:
                        const NeverScrollableScrollPhysics(), // Evita rolagem independente
                    itemCount: _segmentoSelecionado != null
                        ? _gastos[_segmentoSelecionado]!.length
                        : 0,
                    itemBuilder: (context, index) {
                      final item = _gastos[_segmentoSelecionado]![index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Informações do Item
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Título
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item['titulo'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              iconSize: 18,
                                              onPressed: () => _editarItem(
                                                  _segmentoSelecionado!, index),
                                              icon: const Icon(Icons.edit,
                                                  color: Colors.orange),
                                              tooltip: "Editar Item",
                                            ),
                                            // Botão de remover
                                            IconButton(
                                              iconSize: 18,
                                              onPressed: () => _removerItem(
                                                  _segmentoSelecionado!, index),
                                              icon: const Icon(Icons.delete,
                                                  color: Colors.red),
                                              tooltip: "Remover Item",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),

                                    // Data e Descrição
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${item['data']} - ${item['descricao']}',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          'R\$ ${item['valor'].toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GraficoDespesasBarra extends StatefulWidget {
  final Map<String, double> segmentos;
  final ValueChanged<String> onSegmentoSelecionado;

  const GraficoDespesasBarra({
    Key? key,
    required this.segmentos,
    required this.onSegmentoSelecionado,
  }) : super(key: key);

  @override
  _GraficoDespesasBarraState createState() => _GraficoDespesasBarraState();
}

class _GraficoDespesasBarraState extends State<GraficoDespesasBarra> {
  String? _segmentoSelecionado;

  @override
  Widget build(BuildContext context) {
    final maxY = widget.segmentos.values.reduce((a, b) => a > b ? a : b);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          maxY: maxY * 1.2, // Espaço extra no topo
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.grey, width: 1),
          ),
          gridData: FlGridData(show: true),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => Colors.grey.shade900,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${widget.segmentos.keys.elementAt(groupIndex)}\nR\$ ${rod.toY.toStringAsFixed(2)}',
                  const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            touchCallback: (event, response) {
              if (response != null &&
                  response.spot != null &&
                  event.isInterestedForInteractions) {
                final touchedIndex = response.spot!.touchedBarGroupIndex;
                final segmento = widget.segmentos.keys.elementAt(touchedIndex);
                setState(() {
                  _segmentoSelecionado = segmento;
                });
                widget.onSegmentoSelecionado(segmento);
              } else {
                setState(() {
                  _segmentoSelecionado = null;
                });
                widget.onSegmentoSelecionado('');
              }
            },
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    'R\$ ${value.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= widget.segmentos.keys.length) return Container();
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      widget.segmentos.keys.elementAt(index),
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups:
              widget.segmentos.entries.toList().asMap().entries.map((entry) {
            final index = entry.key;
            final segment = entry.value;
            final isSelected = _segmentoSelecionado == segment.key;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: segment.value,
                  color: isSelected ? Colors.red : Colors.redAccent,
                  width: isSelected ? 15 : 10,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
              showingTooltipIndicators: [0],
            );
          }).toList(),
        ),
      ),
    );
  }
}

