import 'package:do_money_teste/screens/carteira_digital.dart';
import 'package:do_money_teste/screens/perfil.dart';
import 'package:do_money_teste/screens/ranking.dart';
import 'package:flutter/material.dart';
import 'package:do_money_teste/screens/subscreens/predio_domoney.dart';
import 'subscreens/balanco_financeiro.dart';
import 'artigos.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex =
      2; // Definir o índice 2 (Home) como selecionado inicialmente

  // Lista de widgets que representam as diferentes páginas
  static final List<Widget> _pages = <Widget>[
    const RankingPage(), // Página de Ranking
    const CarteiraDigitalPage(), // Página de Carteira Digital
    Column(
      children: [
        /*Noticias(),*/
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 16),
            children: [
              PredioDomoney(),
            ],
          ),
        ),
      ],
    ),
    ArticlesPage(), // Página de Artigos
    const ProfilePage(), // Página de Perfil
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
        actions: [
          IconButton(
            icon: const Icon(Icons.insights, color: Colors.white, size: 28),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const BalancoFinanceiro();
                  },
                ),
              );
            },
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 28),
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
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
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
              leading: const Icon(Icons.help, color: Colors.black),
              title: const Text('Ajuda e Suporte'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/help');
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
              leading: const Icon(Icons.info, color: Colors.black),
              title: const Text('Sobre'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/about');
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.black),
              title: const Text('Sair'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/login');
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 0, // Esconde as legendas
        unselectedFontSize: 0, // Esconde as legendas
        iconSize: 28, // Ajusta o tamanho dos ícones
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 10.0), // Adiciona espaçamento lateral
              child: Icon(Icons.insights),
            ),
            label: '', // Remove o texto do rótulo
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
