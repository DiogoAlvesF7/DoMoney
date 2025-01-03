import 'package:flutter/material.dart';

class PredioDoMoneyPage extends StatefulWidget {
  const PredioDoMoneyPage({super.key});

  @override
  _PredioDoMoneyPageState createState() => _PredioDoMoneyPageState();
}

class _PredioDoMoneyPageState extends State<PredioDoMoneyPage> {
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

  int _selectedModulo = -1;

  void _abrirDrawer(BuildContext ctx, int index) {
    setState(() {
      _selectedModulo = index;
    });
    Scaffold.of(ctx).openEndDrawer();
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
      endDrawer: _selectedModulo != -1
          ? _buildModuleDrawer(_modulos[_selectedModulo])
          : null,
      body: Builder(
        builder: (ctx) => Row(
          children: [
            // Prédio na lateral esquerda
            Image.asset(
              'assets/images/Captura de tela 2024-12-18 210631.png',
              width: screenWidth * 0.35,
              height: screenHeight,
              fit: BoxFit.cover,
            ),
            // Caminho de conquistas
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: _modulos.length,
                  itemBuilder: (context, index) {
                    final modulo = _modulos[index];
                    return Align(
                      alignment: index.isEven
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Título do módulo
                          Container(
                            constraints: const BoxConstraints(maxWidth: 120),
                            child: Text(
                              modulo['titulo'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Botão do módulo
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              ModuleButton(
                                icon: modulo['icone'],
                                onTap: () => _abrirDrawer(ctx, index),
                              ),
                              // Estrelas abaixo
                              Positioned(
                                bottom: -25,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(3, (starIndex) {
                                    final double threshold =
                                        (modulo["progresso"] / 3.0) *
                                            (starIndex + 1);
                                    return _buildStar(
                                        threshold, modulo["progresso"]);
                                  }),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStar(double threshold, double progresso) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.star,
          size: 20,
          color: Colors.grey[300], // Fundo da estrela
        ),
        ClipRect(
          clipper: _HalfStarClipper(progresso / threshold),
          child: const Icon(
            Icons.star,
            size: 20,
            color: Colors.yellow, // Preenchimento da estrela
          ),
        ),
      ],
    );
  }

  Widget _buildModuleDrawer(Map<String, dynamic> modulo) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.orange,
            ),
            child: Center(
              child: Text(
                modulo["titulo"],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.book, color: Colors.orange),
            title: const Text("Materiais Didáticos"),
            onTap: () {
              // Abrir página de materiais didáticos
            },
          ),
          ListTile(
            leading: const Icon(Icons.quiz, color: Colors.orange),
            title: const Text("Quizzes"),
            onTap: () {
              // Abrir página de quizzes
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Progresso",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: modulo["progresso"],
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
                const SizedBox(height: 8),
                Text(
                  "Concluído: ${(modulo["progresso"] * 100).toInt()}%",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
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

class ModuleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double progress;

  const ModuleButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.progress = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 120, // Aumentado para comportar a sombra e estrelas
        height: 100, // Aumentado para comportar o conteúdo extra
        child: Stack(
          clipBehavior: Clip.none, // Permitir que conteúdo transborde
          alignment: Alignment.center,
          children: [
            // Sombra achatada
            Positioned(
              bottom: 43, // Ajuste para alinhar com a base do botão
              child: CustomPaint(
                size: const Size(80, 12), // Tamanho da sombra
                painter: ButtonShadowPainter(),
              ),
            ),
            // Botão principal
            Container(
              width: 100, // Largura maior para o formato oval
              height: 80, // Altura menor para o formato oval
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
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                  width: 2,
                ),
              ),
              child: Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
            ),
            // Estrelas abaixo do botão
            Positioned(
              bottom: 0, // Reposicionar para aparecer abaixo do botão
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  final double threshold = (index + 1) / 3.0;
                  return Icon(
                    Icons.star,
                    size: 25,
                    color: progress >= threshold
                        ? Colors.yellow
                        : const Color.fromARGB(255, 238, 214, 3),
                    shadows: [
                      Shadow(
                        offset: const Offset(2, 2),
                        blurRadius: 1,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

class ButtonShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.orange[700]!;

    // Ponto inicial: à esquerda, no ponto mais largo do botão
    final path = Path()
      ..moveTo(0, 0) // Ponto inicial
      ..lineTo(0, size.height) // Prolongamento para baixo
      ..arcToPoint(
        Offset(
            size.width, size.height), // Desenho do arco conectando as laterais
        radius: Radius.circular(size.width / 2),
        clockwise: false,
      )
      ..lineTo(size.width, 0) // Prolongamento para cima
      ..close(); // Conecta o último ponto ao primeiro

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
