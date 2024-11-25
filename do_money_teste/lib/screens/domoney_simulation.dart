import 'package:do_money_teste/screens/home_page.dart';
import 'package:do_money_teste/screens/subscreens/predio_domoney.dart';
import 'package:flutter/material.dart';

class PredioDoMoneyPage extends StatefulWidget {
  const PredioDoMoneyPage({super.key});

  @override
  _PredioDoMoneyPageState createState() => _PredioDoMoneyPageState();
}

class _PredioDoMoneyPageState extends State<PredioDoMoneyPage> {
  int _selectedModulo = -1; // Nenhum módulo selecionado inicialmente
  final List<Map<String, dynamic>> _modulos = [
    {"icone": Icons.lightbulb, "titulo": "Introdução", "progresso": 1.0},
    {
      "icone": Icons.monetization_on,
      "titulo": "Gestão de Gastos",
      "progresso": 0.6
    },
    {"icone": Icons.bar_chart, "titulo": "Investimentos", "progresso": 0.3},
    {"icone": Icons.insights, "titulo": "Planejamento", "progresso": 0.1},
    {"icone": Icons.sim_card, "titulo": "Simulação Avançada", "progresso": 0.0},
  ];

  void _abrirModulo(int index) {
    setState(() {
      _selectedModulo = index;
    });
  }

  void _fecharDrawer() {
    setState(() {
      _selectedModulo = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Prédio DoMoney",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Row(
        children: [
          // Prédio na lateral esquerda
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              child: Image.asset(
                'assets/images/Captura de tela 2024-11-25 115059.png',
                width: screenWidth * 0.4,
                height: screenHeight,
                fit: BoxFit.cover,
                opacity: AlwaysStoppedAnimation(0.4),
              )),
          // Caminho de conquistas
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemCount: _modulos.length,
                    itemBuilder: (context, index) {
                      final modulo = _modulos[index];
                      final isSelected = _selectedModulo == index;

                      return GestureDetector(
                        onTap: () => _abrirModulo(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.only(
                            left: index % 2 == 0 ? 50 : 100,
                            right: index % 2 == 0 ? 100 : 50,
                            top: 20,
                          ),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: isSelected
                                  ? [Colors.orange[700]!, Colors.orange[400]!]
                                  : [Colors.orange[400]!, Colors.orange[300]!],
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                modulo['icone'],
                                color: Colors.white,
                                size: 40,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                modulo['titulo'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Drawer com informações detalhadas
                if (_selectedModulo != -1)
                  Positioned.fill(
                    child: Drawer(
                      elevation: 16,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _modulos[_selectedModulo]['titulo'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: _fecharDrawer,
                                ),
                              ],
                            ),
                            const Divider(),
                            Text(
                              "Progresso: ${(_modulos[_selectedModulo]['progresso'] * 100).toInt()}%",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 16),
                            const Text("Materiais Didáticos: 5"),
                            const Text("Quizzes: 5"),
                            const Text("Progresso Geral: 60%"),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildModuloItem(String nome, IconData icone, Color color) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 1,
              offset: const Offset(2, 4), // Sombra externa
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.2),
              blurRadius: 2,
              spreadRadius: 1,
              offset: const Offset(-2, -2), // Sombra interna curvada
            ),
          ],
        ),
        child: Icon(
          icone,
          color: Colors.white,
          size: 40,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        nome,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ],
  );
}
