import 'package:flutter/material.dart';

class PredioDomoney extends StatefulWidget {
  final VoidCallback? onTap; // Callback para manipular toques

  const PredioDomoney({super.key, this.onTap});

  @override
  _PredioDomoneyState createState() => _PredioDomoneyState();
}

class _PredioDomoneyState extends State<PredioDomoney>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap, // Executa o callback passado pelo widget pai
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Roof(), // Teto do prédio
          BuildingStructure(), // Corpo do prédio
          DoorFloor(), // Porta
        ],
      ),
    );
  }
}

// Teto
class Roof extends StatelessWidget {
  const Roof({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165, // Mesma largura que o prédio
      height: 40, // Altura proporcional
      child: ClipPath(
        clipper: TriangleClipper(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[700], // Cor sólida
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                offset:
                    const Offset(0, 3), // Reduzir sombra para evitar espaços
                blurRadius: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Corpo do prédio
class BuildingStructure extends StatelessWidget {
  const BuildingStructure({super.key});

  Widget _buildBuildingFloor(double largura, bool isLargeFloor) {
    return Container(
      width: largura,
      height: isLargeFloor ? 80 : 61, // Altura maior para o andar intermediário
      decoration: BoxDecoration(
        color: Colors.grey[500],
        border: Border.all(color: Colors.black, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Linhas horizontais decorativas no andar
          Positioned(
            top: 10,
            left: 5,
            right: 5,
            child: Container(
              height: 2,
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 5,
            right: 5,
            child: Container(
              height: 2,
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          // Janelas
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      isLargeFloor ? 4 : 4,
                      (index) => isLargeFloor
                          ? const LargeDynamicWindow()
                          : const DynamicWindow(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      isLargeFloor ? 4 : 4,
                      (index) => isLargeFloor
                          ? const LargeDynamicWindow()
                          : const DynamicWindow(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Detalhes laterais (ornamentos)
          Positioned(
            left: -5,
            top: 0,
            bottom: 0,
            child: Container(
              width: 10,
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.5),
              ),
            ),
          ),
          Positioned(
            right: -5,
            top: 0,
            bottom: 0,
            child: Container(
              width: 10,
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.5),
              ),
            ),
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
        _buildRoundedContainer(175),
        _buildBuildingFloor(165, false),
        _buildRoundedContainer(175),
        _buildBuildingFloor(165, false),
        _buildRoundedContainer(175),
        _buildBuildingFloor(165, false),
        _buildRoundedContainer(180),
        _buildBuildingFloor(190, true),
        _buildRoundedContainer(203),
      ],
    );
  }

  Widget _buildRoundedContainer(double largura) {
    return Container(
      width: largura,
      height: 10,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Colors.black,
          width: 0.4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Linhas decorativas horizontais
          Positioned(
            top: 3,
            left: 5,
            right: 5,
            child: Container(
              height: 2,
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          Positioned(
            bottom: 3,
            left: 5,
            right: 5,
            child: Container(
              height: 2,
              color: Colors.black.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }
}

// Andar da porta
class DoorFloor extends StatelessWidget {
  const DoorFloor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey[500], // Tom sólido
        border: Border.all(
          color: Colors.black,
          width: 0.8,
        ), // Borda rústica
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Linhas horizontais decorativas
          Positioned(
            top: 10,
            left: 5,
            right: 5,
            child: Container(
              height: 2,
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 5,
            right: 5,
            child: Container(
              height: 2,
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          // Detalhes verticais rústicos (laterais)
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                3,
                (index) => Container(
                  width: 8,
                  height: 15,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    border: Border.all(color: Colors.black, width: 0.5),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                3,
                (index) => Container(
                  width: 8,
                  height: 15,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    border: Border.all(color: Colors.black, width: 0.5),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 10,
              bottom: 10,
              left: 20,
              right: 160,
              child: _buildVerticalDetail()),
          Positioned(
              top: 10,
              bottom: 10,
              left: 40,
              right: 140,
              child: _buildVerticalDetail()),
          Positioned(
              top: 10,
              bottom: 10,
              left: 160,
              right: 20,
              child: _buildVerticalDetail()),
          Positioned(
              top: 10,
              bottom: 10,
              left: 140,
              right: 40,
              child: _buildVerticalDetail()),
          // Porta
          Positioned(
            top: 10,
            bottom: 10,
            left: 80,
            right: 80,
            child: AnimatedDoor(),
          ),
        ],
      ),
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
      color: Colors.grey[400],
      border: Border.all(color: Colors.black, width: 0.5), // Borda preta
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: const Offset(1, 1),
          blurRadius: 2,
        ),
      ],
    ),
    child: Stack(
      children: [
        // Linha horizontal decorativa superior
        Positioned(
          top: 8,
          left: 2,
          right: 2,
          child: Container(
            height: 2,
            color: Colors.black.withOpacity(0.3),
          ),
        ),
        // Linha horizontal decorativa central
        Positioned(
          top: 23,
          left: 2,
          right: 2,
          child: Container(
            height: 2,
            color: Colors.black.withOpacity(0.3),
          ),
        ),
        // Linha horizontal decorativa inferior
        Positioned(
          bottom: 8,
          left: 2,
          right: 2,
          child: Container(
            height: 2,
            color: Colors.black.withOpacity(0.3),
          ),
        ),
      ],
    ),
  );
}

// Porta animada
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
                    width: 20, // Mesma largura para ambas as portas
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(color: Colors.black, width: 0.9),
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
                    width: 20, // Mesma largura para ambas as portas
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(color: Colors.black, width: 0.9),
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

// Teto
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Base reta
    path.moveTo(0, size.height);

    // Degraus inclinados à esquerda
    path.lineTo(size.width * 0.15, size.height * 0.5);
    path.lineTo(size.width * 0.3, size.height * 0.3);

    // Ponto superior central
    path.lineTo(size.width * 0.5, 0);

    // Degraus inclinados à direita
    path.lineTo(size.width * 0.7, size.height * 0.3);
    path.lineTo(size.width * 0.85, size.height * 0.5);

    // Base reta à direita
    path.lineTo(size.width, size.height);

    // Fecha o caminho
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// Janela dinâmica
class DynamicWindow extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsets? margin;

  const DynamicWindow({
    super.key,
    this.width = 37,
    this.height = 23,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300], // Base da janela
        border: Border.all(color: Colors.black, width: 1), // Contorno preto
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
      ),
    );
  }
}

// Janelas maiores para o andar intermediário
class LargeDynamicWindow extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsets? margin;

  const LargeDynamicWindow({
    super.key,
    this.width = 42,
    this.height = 31,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return DynamicWindow(
      width: width,
      height: height,
      margin: margin,
    );
  }
}

class CEOFloor extends StatelessWidget {
  const CEOFloor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170, // Um pouco mais largo que os outros andares
      height: 90, // Altura maior para destacar
      decoration: BoxDecoration(
        color: Colors.grey[500], // Cor diferenciada
        border: Border.all(
            color: Colors.black, width: 0.8), // Contorno mais evidente
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(2, 4), // Sombra levemente inclinada
            blurRadius: 6,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Janelas exclusivas do andar do CEO
          Positioned(
            top: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                3,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 40,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[100],
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.black, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 2,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Detalhes decorativos
          Positioned(
            bottom: 5,
            child: Container(
              width: 80,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.cyan[100],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyan.withOpacity(0.4),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'CEO Office',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final Animation<double> transitionAnimation;

  CustomPageRoute({required this.child, required this.transitionAnimation})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: const Duration(milliseconds: 800),
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: transitionAnimation,
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 1.3).animate(animation),
        child: child,
      ),
    );
  }
}
