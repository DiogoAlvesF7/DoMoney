import 'package:do_money_teste/screens/home_page.dart';
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
                width: screenWidth * 0.3,
                height: screenHeight,
                fit: BoxFit.cover,
                opacity: AlwaysStoppedAnimation(0.4),
              )),
          // Caminho de conquistas
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                DoMoneyPath(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DoMoneyPath extends StatelessWidget {
  final List<Map<String, dynamic>> modules = [
    {"title": "Introdução", "progress": 1.0, "icon": Icons.lightbulb_outline},
    {"title": "Gestão de Gastos", "progress": 0.8, "icon": Icons.attach_money},
    {"title": "Investimentos", "progress": 0.5, "icon": Icons.bar_chart},
    {"title": "Planejamento", "progress": 0.3, "icon": Icons.trending_up},
    {"title": "Simulação Avançada", "progress": 0.0, "icon": Icons.assessment},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: SingleChildScrollView(
          child: Column(
            children: modules
                .asMap()
                .entries
                .map((entry) => _buildModuleWidget(entry.key, entry.value))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildModuleWidget(int index, Map<String, dynamic> module) {
    final bool isLeftAligned = index % 2 == 0;

    return Row(
      mainAxisAlignment:
          isLeftAligned ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment:
              isLeftAligned ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            // Título do módulo
            Text(
              module['title'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Círculo com símbolo
            Stack(
              alignment: Alignment.center,
              children: [
                // Círculo 3D
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Colors.orange, Colors.deepOrange],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                ),
                // Ícone no centro do círculo
                Icon(
                  module['icon'],
                  size: 40,
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Estrelas de aproveitamento
            _buildStarsWidget(module['progress']),
            const SizedBox(height: 24), // Espaçamento entre os módulos
          ],
        ),
      ],
    );
  }

  Widget _buildStarsWidget(double progress) {
    // Cálculo da quantidade de estrelas preenchidas
    int fullStars =
        (progress * 3).floor(); // Número de estrelas totalmente preenchidas
    double remainingProgress = (progress * 3) -
        fullStars; // Progresso restante para semi-preenchimento

    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (index) {
          if (index < fullStars) {
            // Estrela totalmente preenchida
            return const Icon(Icons.star, color: Colors.amber, size: 24);
          } else if (index == fullStars && remainingProgress > 0) {
            // Estrela semi-preenchida
            return Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.star,
                    color: Colors.grey, size: 24), // Fundo cinza
                ClipRect(
                  clipper: _HalfStarClipper(remainingProgress),
                  child: const Icon(Icons.star,
                      color: Colors.amber, size: 24), // Metade amarela
                ),
              ],
            );
          } else {
            // Estrela não preenchida
            return const Icon(Icons.star_border, color: Colors.grey, size: 24);
          }
        }),
      ),
    );
  }
}

// Clipper para cortar a parte da estrela
class _HalfStarClipper extends CustomClipper<Rect> {
  final double progress; // Entre 0.0 e 1.0

  _HalfStarClipper(this.progress);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width * progress, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}

class ModuleButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ModuleButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Círculo com profundidade e ícone
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Colors.orange, Colors.deepOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                // Sombra externa para profundidade
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(4, 4),
                ),
                // Sombra interna sutil
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(-4, -4),
                  spreadRadius: -2,
                ),
              ],
            ),
            child: Center(
              child: Icon(
                icon,
                size: 40,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8), // Espaçamento entre o botão e o texto
          // Título do módulo
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
