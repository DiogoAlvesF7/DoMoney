import 'package:do_money_teste/screens/artigos.dart';
import 'package:do_money_teste/screens/carteira_digital.dart';
import 'package:do_money_teste/screens/ranking.dart';

import 'screens/home_page.dart';
import 'screens/perfil.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
        textTheme: const TextTheme(),
        scaffoldBackgroundColor: Colors.grey,
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 201, 99, 3),
          centerTitle: true,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/perfil': (context) => const ProfilePage(),
        '/ranking': (context) => const RankingPage(),
        '/artigos': (context) => const ArticlesPage(),
        '/carteira_digital': (context) => const CarteiraDigitalPage(),
      },
    );
  }
}
