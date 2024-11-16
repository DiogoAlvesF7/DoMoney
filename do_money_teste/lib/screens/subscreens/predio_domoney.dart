import 'package:flutter/material.dart';

class PredioDomoney extends StatefulWidget {
  const PredioDomoney({super.key});

  @override
  _PredioDomoneyState createState() => _PredioDomoneyState();
}

class _PredioDomoneyState extends State<PredioDomoney>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapBuilding() {
    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapBuilding,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const OutdoorBanner(), // Outdoor com o nome
            const Roof(), // Teto do prédio
            const BuildingStructure(), // Corpo do prédio com janelas e refletores
            const DoorFloor(), // Porta futurista
          ],
        ),
      ),
    );
  }
}

// Outdoor centralizado no topo do prédio
class OutdoorBanner extends StatelessWidget {
  const OutdoorBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: const Offset(0, 4),
            blurRadius: 6,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Text(
        'DoMoney Enterprises',
        style: TextStyle(
          color: Colors.cyanAccent,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// Teto triangular com efeitos de sombra e gradiente para destacar
class Roof extends StatelessWidget {
  const Roof({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 167,
      height: 40,
      child: ClipPath(
        clipper: TriangleClipper(),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[800]!, Colors.grey[700]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 5),
                blurRadius: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Corpo do prédio com janelas e refletores
class BuildingStructure extends StatelessWidget {
  const BuildingStructure({super.key});

  Widget _buildBuildingFloor(double largura, bool isCurrentLevel) {
    return Container(
      width: largura,
      height: 65,
      margin: const EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
        color: isCurrentLevel ? Colors.yellow[200] : Colors.grey[400],
        border: Border.all(color: Colors.black, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
          if (isCurrentLevel)
            BoxShadow(
              color: Colors.yellow.withOpacity(0.5),
              offset: const Offset(0, -5),
              blurRadius: 10,
              spreadRadius: 3,
            ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) => DynamicWindow()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) => DynamicWindow()),
              ),
            ],
          ),
          Positioned(
            left: -15,
            top: 10,
            child: _buildRotatingSpotlight(),
          ),
          Positioned(
            right: -15,
            top: 10,
            child: _buildRotatingSpotlight(),
          ),
        ],
      ),
    );
  }

  // Janela com estilo neon mais suave
  Widget _buildNeonWindow(double largura, double altura) {
    return Container(
      width: largura,
      height: altura,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.cyanAccent, Colors.blueAccent],
        ),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }

  // Refletor que simula um movimento leve de rotação
  Widget _buildRotatingSpotlight() {
    return Container(
      width: 15,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildBuildingFloor(165, false),
        _buildRoundedContainer(170),
        _buildBuildingFloor(165, false),
        _buildRoundedContainer(187),
        _buildBuildingFloor(165, true), // Andar destacado
        _buildRoundedContainer(170),
        _buildBuildingFloor(165, false),
        _buildRoundedContainer(187),
        _buildBuildingFloor(190, false),
        _buildRoundedContainer(203),
      ],
    );
  }

  Widget _buildRoundedContainer(double largura) {
    return Container(
      width: largura,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey[600],
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }
}

// Andar com a porta futurista

class DoorFloor extends StatelessWidget {
  const DoorFloor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey[600], // Tom mais escuro
        border: Border.all(
            color: Colors.black, width: 0.5), // Mesma borda dos outros andares
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: List.generate(
                4,
                (index) =>
                    _buildVerticalDetail()), // Detalhes laterais à esquerda
          ),
          AnimatedDoor(), // Porta central
          Row(
            children: List.generate(
                4,
                (index) =>
                    _buildVerticalDetail()), // Detalhes laterais à direita
          ),
        ],
      ),
    );
  }

  Widget _buildDoor() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Moldura externa da porta, levemente mais escura
        Container(
          width: 60,
          height: 65,
          decoration: BoxDecoration(
            color: Colors.grey[700], // Tom mais escuro para a moldura
            border: Border.all(color: Colors.black, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 4),
                blurRadius: 6,
              ),
            ],
          ),
        ),
        // Barra luminosa no topo da porta
        Positioned(
          top: 6,
          child: Container(
            width: 30,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.cyanAccent,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyanAccent.withOpacity(0.5),
                  blurRadius: 6,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        ),
        // Portas laterais (direita e esquerda)
        Positioned(
          left: 4,
          child: Container(
            width: 20,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(3),
                bottomLeft: Radius.circular(3),
              ),
              border: Border.all(color: Colors.black, width: 0.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(-2, 4),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 4,
          child: Container(
            width: 20,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(3),
                bottomRight: Radius.circular(3),
              ),
              border: Border.all(color: Colors.black, width: 0.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(2, 4),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ),
        // Indicador vermelho na parte inferior
        Positioned(
          bottom: 6,
          child: Container(
            width: 20,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withOpacity(0.4),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Detalhes verticais laterais
Widget _buildVerticalDetail() {
  return Container(
    width: 8,
    height: 50,
    margin: const EdgeInsets.symmetric(horizontal: 3),
    decoration: BoxDecoration(
      color: Colors.grey[500], // Um tom intermediário
      border: Border.all(color: Colors.black, width: 0.5), // Borda preta
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: const Offset(1, 1),
          blurRadius: 2,
        ),
      ],
    ),
  );
}

class AnimatedDoor extends StatefulWidget {
  const AnimatedDoor({super.key});

  @override
  _AnimatedDoorState createState() => _AnimatedDoorState();
}

class _AnimatedDoorState extends State<AnimatedDoor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _leftDoorAnimation;
  late Animation<double> _rightDoorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Configuração para abrir as portas
    _leftDoorAnimation = Tween<double>(begin: -10, end: -20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _rightDoorAnimation = Tween<double>(begin: 10, end: 20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onMouseEnter(bool isHovered) {
    if (isHovered) {
      _controller.forward(); // Abrir portas
    } else {
      _controller.reverse(); // Fechar portas
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onMouseEnter(true),
      onExit: (_) => _onMouseEnter(false),
      child: SizedBox(
        width: 20, // Largura total das portas juntas
        height: 50, // Altura das portas
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Porta esquerda
            AnimatedBuilder(
              animation: _leftDoorAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_leftDoorAnimation.value, 0),
                  child: Container(
                    width: 40, // Mesma largura para ambas as portas
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      border: Border.all(color: Colors.black, width: 0.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(-2, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            // Porta direita
            AnimatedBuilder(
              animation: _rightDoorAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_rightDoorAnimation.value, 0),
                  child: Container(
                    width: 40, // Mesma largura para ambas as portas
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      border: Border.all(color: Colors.black, width: 0.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(2, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Clipper para o teto triangular
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class DynamicWindow extends StatefulWidget {
  const DynamicWindow({super.key});

  @override
  _DynamicWindowState createState() => _DynamicWindowState();
}

class _DynamicWindowState extends State<DynamicWindow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Duração do ciclo
      vsync: this,
    )..repeat(reverse: true); // Repetir animação continuamente

    _opacityAnimation = Tween<double>(begin: 0.2, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.grey[300], // Cor base da janela
        border: Border.all(color: Colors.black, width: 1), // Contorno preto
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Reflexo dinâmico
          AnimatedBuilder(
            animation: _opacityAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Container(
                  margin: const EdgeInsets.only(top: 5, left: 5),
                  width: 15,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
