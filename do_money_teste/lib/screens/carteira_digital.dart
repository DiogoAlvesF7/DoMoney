import 'package:do_money_teste/screens/subscreens/extrato.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CarteiraDigitalPage extends StatefulWidget {
  const CarteiraDigitalPage({super.key});

  @override
  _CarteiraDigitalPageState createState() => _CarteiraDigitalPageState();
}

class _CarteiraDigitalPageState extends State<CarteiraDigitalPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final double valorTotalCarteira = 30509.04;

  final List<Map<String, dynamic>> segmentos = [
    {"nome": "Ações", "valor": 9149.99, "cor": Colors.blueAccent},
    {"nome": "CDB", "valor": 8970.99, "cor": Colors.greenAccent},
    {"nome": "COE", "valor": 8990.99, "cor": Colors.orangeAccent},
    {"nome": "Debêntures", "valor": 7900.99, "cor": Colors.purpleAccent},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Carteira Digital",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.orange,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          tabs: const [
            Tab(text: "Início"),
            Tab(text: "Extrato"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Página de Início
          _buildInicio(),

          // Página de Extrato
          _buildExtrato(),
        ],
      ),
    );
  }

  // Conteúdo da Página de Início
  Widget _buildInicio() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.white,
                )
              ],
            ),
          ),
          _buildValorTotalCarteira(),
          const SizedBox(height: 24),
          _buildGraficoCircular(),
          const SizedBox(height: 16),
          _buildLegenda(),
          const SizedBox(height: 24),
          _buildSimuladorFinanceiro(),
        ],
      ),
    );
  }

  // Valor Total da Carteira
  Widget _buildValorTotalCarteira() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Valor da carteira",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "R\$ ${valorTotalCarteira.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Atualizado em: 16/12/2024",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }

  // Gráfico Circular Neon
  Widget _buildGraficoCircular() {
    return Center(
      child: SizedBox(
        height: 250,
        child: PieChart(
          PieChartData(
            sectionsSpace: 4,
            centerSpaceRadius: 90, // Espaço central maior (mais fino)
            sections: segmentos.map((segmento) {
              return PieChartSectionData(
                value: segmento["valor"],
                color: segmento["cor"],
                radius: 30,
                title: "",
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // Legenda do Gráfico
  Widget _buildLegenda() {
    return Column(
      children: segmentos.map((segmento) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: segmento["cor"],
            radius: 8,
          ),
          title: Text(
            segmento["nome"],
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          trailing: Column(
            children: [
              Text(
                "R\$ ${segmento["valor"].toStringAsFixed(2)}",
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "27% da carteira",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // Placeholder do Simulador
  Widget _buildSimuladorFinanceiro() {
    String _tipoInvestimento = 'Ações'; // Valor inicial do dropdown
    String _periodoInvestimento = '1 mês';
    double _valorInvestido = 0.0;
    double? _resultadoSimulacao;

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título
              const Text(
                "Simulador Financeiro",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              // Tipo de Investimento
              const Text(
                "Tipo de Investimento:",
                style: TextStyle(color: Colors.white70),
              ),
              DropdownButton<String>(
                dropdownColor: Colors.grey[850],
                value: _tipoInvestimento,
                isExpanded: true,
                style: const TextStyle(color: Colors.white),
                underline: Container(),
                onChanged: (String? newValue) {
                  setState(() {
                    _tipoInvestimento = newValue!;
                  });
                },
                items: <String>['Ações', 'CDB', 'COE', 'Debêntures']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),

              // Valor do Investimento
              const Text(
                "Valor do Investimento:",
                style: TextStyle(color: Colors.white70),
              ),
              TextField(
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[850],
                  hintText: "Digite o valor",
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  _valorInvestido = double.tryParse(value) ?? 0.0;
                },
              ),
              const SizedBox(height: 12),

              // Período do Investimento
              const Text(
                "Período do Investimento:",
                style: TextStyle(color: Colors.white70),
              ),
              DropdownButton<String>(
                dropdownColor: Colors.grey[850],
                value: _periodoInvestimento,
                isExpanded: true,
                style: const TextStyle(color: Colors.white),
                underline: Container(),
                onChanged: (String? newValue) {
                  setState(() {
                    _periodoInvestimento = newValue!;
                  });
                },
                items: <String>['1 mês', '6 meses', '1 ano', '5 anos']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Botão de Simular
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // Simulação de lógica fictícia
                      double rendimento = 0.0;
                      if (_tipoInvestimento == 'Ações') rendimento = 0.15;
                      if (_tipoInvestimento == 'CDB') rendimento = 0.05;
                      if (_tipoInvestimento == 'COE') rendimento = 0.10;
                      if (_tipoInvestimento == 'Debêntures') rendimento = 0.08;

                      int multiplicador = _periodoInvestimento == '1 mês'
                          ? 1
                          : _periodoInvestimento == '6 meses'
                              ? 6
                              : _periodoInvestimento == '1 ano'
                                  ? 12
                                  : 60;

                      _resultadoSimulacao = _valorInvestido *
                          (1 + (rendimento * multiplicador / 12));
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text(
                    "Simular",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Resultado da Simulação
              if (_resultadoSimulacao != null)
                Center(
                  child: Text(
                    "Valor Final: R\$ ${_resultadoSimulacao!.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // Página de Extrato
  Widget _buildExtrato() {
    return ExtratoPage();
  }
}
