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
            const Roof(), // Teto do prédio
            const BuildingStructure(), // Corpo do prédio
            const DoorFloor(), // Andar da porta
          ],
        ),
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

// Corpo do prédio com andares coloridos e efeito 3D
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) => _buildWindow(32, 25)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) => _buildWindow(32, 25)),
          ),
        ],
      ),
    );
  }

  Widget _buildWindow(double largura, double altura) {
    return Container(
      width: largura,
      height: altura,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blueAccent, Colors.lightBlueAccent],
        ),
        border: Border.all(color: Colors.black, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(1, 1),
            blurRadius: 2,
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

// Andar com a porta, agora com sombra e gradiente suave
class DoorFloor extends StatelessWidget {
  const DoorFloor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        border: Border.all(color: Colors.black, width: 0.5),
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
            children: List.generate(4, (index) => _buildVerticalDetail()),
          ),
          _buildSlidingDoor(),
          Row(
            children: List.generate(4, (index) => _buildVerticalDetail()),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDetail() {
    return Container(
      width: 7,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.grey[600],
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

  Widget _buildSlidingDoor() {
    return Container(
      width: 80,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueGrey[100]!.withOpacity(0.9), Colors.grey[300]!],
        ),
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 35,
                height: 50,
                color: Colors.blueGrey[100]?.withOpacity(0.7),
              ),
              Container(
                width: 35,
                height: 50,
                color: Colors.blueGrey[100]?.withOpacity(0.7),
              ),
            ],
          ),
          Positioned(
            top: 5,
            child: Container(
              width: 15,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.red[400],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
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
