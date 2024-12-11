import 'package:do_money_teste/screens/domoney_simulation.dart';
import 'package:flutter/material.dart';
import 'package:do_money_teste/screens/subscreens/predio_domoney.dart';
import 'package:do_money_teste/screens/carteira_digital.dart';
import 'package:do_money_teste/screens/perfil.dart';
import 'subscreens/balanco_financeiro.dart';
import 'noticias.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;

  static final List<Widget> _pages = <Widget>[
    const BalancoFinanceiro(),
    const CarteiraDigitalPage(),
    const _HomePageContent(), // Conteúdo da Home
    NoticiasPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: const Color(0xFFFF9800),
        elevation: 0,
        title: const Text(
          'DoMoney',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 28),
              tooltip: 'Abrir menu',
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFFF9800),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child:
                        Icon(Icons.person, size: 40, color: Color(0xFFFF9800)),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Bem-vindo, Usuário!',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.lightbulb, color: Colors.black),
              title: const Text('Como Jogar'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/about');
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.black),
              title: const Text('Notificações'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/notifications');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.black),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.black),
              title: const Text('Sair'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/logout');
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 28,
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(Icons.insights),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(Icons.insert_chart_rounded),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(Icons.home),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(Icons.newspaper_rounded),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(Icons.person),
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey[700],
        onTap: _onItemTapped,
      ),
    );
  }
}

// Conteúdo da Home
class _HomePageContent extends StatelessWidget {
  const _HomePageContent();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        // Fundo com sombras
        DynamicBackground(
          size: Size(screenWidth, screenHeight),
          painter: DynamicBackgroundPainter(heights: [
            0.3,
            0.4,
            0.35,
            0.45,
            0.5,
            0.6,
          ]),
        ),
        // Conteúdo posicionado
        Stack(
          alignment: Alignment.center,
          children: [
            // Texto animado "Clique para entrar"
            Positioned(
              top: screenHeight * 0.03,
              child: const FadingText(),
            ),
            // Prédio central
            Positioned(
              top: screenHeight * 0.07,
              child: PredioDomoney(
                onTap: () {
                  // Garantir que o Navigator utilize o contexto correto
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PredioDoMoneyPage(),
                    ),
                  );
                },
              ),
            ),
            // Barra de progresso
            Positioned(
              top: screenHeight *
                  0.75, // Ajuste para posicionar abaixo do prédio
              child: const ProgressIndicator(progress: 0.75),
            ),
          ],
        ),
      ],
    );
  }
}

// Clique para entrar
class FadingText extends StatefulWidget {
  const FadingText({super.key});

  @override
  _FadingTextState createState() => _FadingTextState();
}

class _FadingTextState extends State<FadingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: const Text(
        "Clique para entrar",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

// Barra de progresso
class ProgressIndicator extends StatelessWidget {
  final double progress; // Progresso atual (de 0.0 a 1.0)

  const ProgressIndicator({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Progresso atual",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8), // Espaçamento entre o texto e a barra
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: progress),
          duration: const Duration(seconds: 2), // Tempo da animação
          builder: (context, value, child) {
            return Stack(
              alignment:
                  Alignment.centerLeft, // Garantir alinhamento à esquerda
              children: [
                // Barra de fundo
                Container(
                  width: screenWidth * 0.6,
                  height: 16,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 219, 214, 214),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
                // Barra de progresso preenchida
                Container(
                  width: screenWidth * 0.6 * value, // Crescimento da esquerda
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.horizontal(
                      left:
                          Radius.circular(4), // Bordas arredondadas à esquerda
                      right: Radius.circular(
                          4), // Bordas à direita ajustadas dinamicamente
                    ),
                  ),
                ),
                // Texto de porcentagem no centro
                Padding(
                  padding: const EdgeInsets.only(left: 90.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${(value * 100).toInt()}%", // Progresso em porcentagem
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

// Fundo dinâmico com prédios
class DynamicBackground extends StatefulWidget {
  const DynamicBackground(
      {super.key,
      required Size size,
      required DynamicBackgroundPainter painter});

  @override
  _DynamicBackgroundState createState() => _DynamicBackgroundState();
}

class _DynamicBackgroundState extends State<DynamicBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _heightAnimations;

  @override
  void initState() {
    super.initState();

    // Configurando o controlador de animação
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    // Criando animações independentes para cada prédio
    _heightAnimations = List.generate(6, (index) {
      final start = 0.3 + (index * 0.05); // Altura inicial relativa
      final end = start + 0.15; // Altura final maior
      return Tween<double>(begin: start, end: end).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * 0.15, // Começa em momentos diferentes para cada prédio
            1.0,
            curve: Curves.easeInOut,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: MediaQuery.of(context).size,
          painter: DynamicBackgroundPainter(
            heights: _heightAnimations.map((anim) => anim.value).toList(),
          ),
        );
      },
    );
  }
}

class DynamicBackgroundPainter extends CustomPainter {
  final List<double> heights;

  DynamicBackgroundPainter({required this.heights});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.grey[200]!.withOpacity(0.5), Colors.grey[400]!],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));

    final buildingWidth = size.width / 8;

    for (int i = 0; i < heights.length; i++) {
      final x = i * buildingWidth * 1.5;
      final height = size.height * heights[i];
      final rect =
          Rect.fromLTWH(x, size.height - height, buildingWidth, height);
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
