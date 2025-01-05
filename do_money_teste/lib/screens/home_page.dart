import 'package:do_money_teste/screens/subscreens/home_page/domoney_simulation.dart';
import 'package:flutter/material.dart';
import 'package:do_money_teste/screens/subscreens/home_page/predio_domoney.dart';
import 'package:do_money_teste/screens/carteira_digital.dart';
import 'package:do_money_teste/screens/perfil.dart';
import 'balanco_financeiro.dart';
import 'noticias.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;

  static final List<Widget> _pages = <Widget>[
    const BalancoFinanceiro(),
    const CarteiraDigitalPage(),
    const _HomePageContent(), // Conteúdo da Home
    const NoticiasPage(),
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
      drawer: const CustomDrawer(),
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

  Widget _buildStatCard({
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.orange[600],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black, // Fundo escuro
        child: Column(
          children: [
            // Cabeçalho reformulado
            DrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 27, 27, 27),
                      Color(0xFF292929)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // Avatar e informações principais
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundImage: AssetImage(
                                "assets/images/Captura de tela 2024-12-18 093558.png"),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Diogo Ferreira',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Sócio Sênior', // Cargo do usuário
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.verified,
                                      color: Colors.blue, size: 14),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Indicadores em colunas
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildInfoRow("300.509,04",
                              icon: Icons.attach_money,
                              iconColor: Colors.green), // Saldo
                          _buildInfoRow(
                            "22.487 XP",
                          ), // XP
                          _buildInfoRow(
                            "7",
                            icon: Icons.emoji_events,
                            iconColor: Colors.amber,
                          ), // Conquistas
                          _buildInfoRow(
                            "5",
                            icon: Icons.group,
                            iconColor: Colors.grey[600],
                          ), //Amigos
                        ],
                      ),
                    ),
                  ],
                )),

            // Opções do Drawer
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: const [
                  DrawerOption(
                    icon: Icons.lightbulb,
                    label: 'Tutorial e Dicas',
                    routeName: '/about',
                  ),
                  Divider(
                    color: Colors.white10,
                    thickness: 1,
                    height: 1,
                  ),
                  DrawerOption(
                    icon: Icons.notifications,
                    label: 'Notificações',
                    routeName: '/notificacoes',
                  ),
                  Divider(
                    color: Colors.white10,
                    thickness: 1,
                    height: 1,
                  ),
                  DrawerOption(
                    icon: Icons.settings,
                    label: 'Configurações',
                    routeName: '/settings',
                  ),
                  Divider(
                    color: Colors.white10,
                    thickness: 1,
                    height: 1,
                  ),
                  DrawerOption(
                    icon: Icons.exit_to_app,
                    label: 'Sair',
                    routeName: '/logout',
                    isDanger: true,
                  ),
                ],
              ),
            ),

            // Rodapé fixo
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Text(
                    "DoMoney v1.0.0",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      "Política de Privacidade",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para os ícones e informações no cabeçalho
  Widget _buildInfoRow(String text, {IconData? icon, Color? iconColor}) {
    final parts = text.split(" "); // Dividir o texto em partes (número e label)

    // Garantir que o texto está no formato esperado
    if (parts.length < 2) {
      return Row(
        children: [
          Text(
            text, // Apenas retorna o texto original
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (icon != null) ...[
            const SizedBox(width: 2),
            Icon(
              icon,
              color: iconColor ?? Colors.white,
              size: 20,
            ),
          ],
        ],
      );
    }

    return Row(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: parts[0], // Parte numérica
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const TextSpan(text: " "), // Espaço entre número e label
              TextSpan(
                text: parts[1], // Parte de texto (exemplo: XP)
                style: const TextStyle(
                  color: Colors.orange, // Cor diferente para "XP"
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
        ),
        if (icon != null) ...[
          const SizedBox(width: 4),
          Icon(
            icon,
            color: iconColor ?? Colors.white,
            size: 18,
          ),
        ],
      ],
    );
  }
}

// Classe para opções do Drawer
class DrawerOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String routeName;
  final bool isDanger;

  const DrawerOption({
    super.key,
    required this.icon,
    required this.label,
    required this.routeName,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDanger ? Colors.redAccent : Colors.white,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isDanger ? Colors.redAccent : Colors.white,
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(routeName);
      },
      tileColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      horizontalTitleGap: 12,
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: Colors.white54,
      ),
      visualDensity: VisualDensity.compact,
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
        const SizedBox(height: 5), // Espaçamento entre o texto e a barra
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
                  width: screenWidth * 0.75,
                  height: 16,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBEBEB),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 1,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                // Barra de progresso preenchida
                Container(
                  width: screenWidth * 0.75 * value, // Crescimento da esquerda
                  height: 18,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 243, 159, 32),
                        Color.fromARGB(255, 228, 143, 15)
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
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
                  padding: const EdgeInsets.only(left: 116.0),
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
