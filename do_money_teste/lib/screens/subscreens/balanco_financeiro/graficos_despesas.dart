import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraficoDespesas extends StatefulWidget {
  const GraficoDespesas({super.key, required Map<String, double> data});

  @override
  // ignore: library_private_types_in_public_api
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
    const double centerRadius = 85.0; // Vão central mais destacado
    const double sliceRadius = 40.0; // Casca mais fina

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Valor total das despesas no topo
                const Text(
                  "Total: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "R\$ ${total.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
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
                                  ? Colors.red[600]
                                  : Colors.red[400],
                              value: displayValue.toDouble(),
                              title:
                                  "${((entry.value / total) * 100).toStringAsFixed(1)}%",
                              radius:
                                  isSelected ? sliceRadius + 8 : sliceRadius,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _segmentoSelecionado ?? "Clique no gráfico",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white54,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (_segmentoSelecionado != null)
                                  Text(
                                    "R\$ ${_valorSegmentoSelecionado?.toStringAsFixed(2) ?? "0.00"}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
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
                const SizedBox(height: 18),
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
                              ? 0
                              : 1, // Gira o ícone suavemente
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
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _segmentoSelecionado != null
                        ? _gastos[_segmentoSelecionado]!.length
                        : 0,
                    itemBuilder: (context, index) {
                      final item = _gastos[_segmentoSelecionado]![index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(2, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Título e Valor
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Título
                                Expanded(
                                  child: Text(
                                    item['titulo'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                // Valor
                                Text(
                                  'R\$ ${item['valor'].toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: item['valor'] > 0
                                        ? Colors.white
                                        : Colors.greenAccent,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Data e Descrição
                            Text(
                              '${item['data']} - ${item['descricao']}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Divider(color: Colors.white12, thickness: 1),
                            // Botões de Ação
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Botão Editar
                                TextButton.icon(
                                  onPressed: () =>
                                      _editarItem(_segmentoSelecionado!, index),
                                  icon: const Icon(Icons.edit,
                                      color: Colors.amber, size: 18),
                                  label: const Text(
                                    'Editar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                // Botão Remover
                                TextButton.icon(
                                  onPressed: () => _removerItem(
                                      _segmentoSelecionado!, index),
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red, size: 18),
                                  label: const Text(
                                    'Remover',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
