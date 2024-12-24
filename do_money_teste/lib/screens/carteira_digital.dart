import 'package:do_money_teste/screens/subscreens/carteira_digital/corretora.dart';
import 'package:do_money_teste/screens/subscreens/carteira_digital/extrato.dart';
import 'package:do_money_teste/screens/subscreens/carteira_digital/grafico_carteira_digital.dart';
import 'package:do_money_teste/screens/subscreens/carteira_digital/grafico_historico.dart';
import 'package:do_money_teste/screens/subscreens/carteira_digital/simulador.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CarteiraDigitalPage extends StatefulWidget {
  const CarteiraDigitalPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
    _tabController = TabController(length: 4, vsync: this);
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
            fontSize: 12,
            fontFamily: 'Montserrat',
          ),
          tabs: const [
            Tab(text: "Início"),
            Tab(text: "Extrato"),
            Tab(text: "Simulador"),
            Tab(text: "Corretora"),
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
          // Página de Simulador
          _buildSimulador(),
          // Página de Corretora
          _buildCorretora(),
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
          _buildValorTotalCarteira(),
          const SizedBox(height: 24),
          const GraficoCarteiraDigital(),
          const SizedBox(height: 24),
          const HistoricoProgresso(
            pontosHistorico: [
              FlSpot(0, 17509.04),
              FlSpot(1, 25000.00),
              FlSpot(2, 26000.00),
              FlSpot(3, 23500.00),
              FlSpot(4, 28500.00),
              FlSpot(5, 30509.04),
            ],
            maxValue: 30509.04,
            minValue: 17509.04,
          ),
        ],
      ),
    );
  }

  // Página de Extrato
  Widget _buildExtrato() {
    return const ExtratoPage();
  }

  Widget _buildSimulador() {
    return const SimuladorFinanceiroPage();
  }

  Widget _buildCorretora() {
    return const CorretoraPage();
  }

  // Valor Total da Carteira com funcionalidade do "olho"
  Widget _buildValorTotalCarteira() {
    bool mostrarValor = true;

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 28.0),
                    child: Text(
                      "Valor Total da Carteira",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        mostrarValor = !mostrarValor;
                      });
                    },
                    child: Icon(
                      mostrarValor ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.white54),
              Text(
                mostrarValor
                    ? "R\$ ${valorTotalCarteira.toStringAsFixed(2)}"
                    : "********",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
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
      },
    );
  }
}
