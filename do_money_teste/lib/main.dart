import 'package:do_money_teste/screens/login.dart';
import 'package:do_money_teste/screens/menu/configuracoes.dart';
import 'package:do_money_teste/screens/menu/notificacoes.dart';
import 'package:do_money_teste/screens/menu/sair.dart';
import 'package:do_money_teste/screens/menu/sobre.dart';

import 'screens/noticias.dart';
import 'screens/carteira_digital.dart';
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
      title: 'DoMoney',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.orange, // Adicionado para usar tons consistentes
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        scaffoldBackgroundColor:
            const Color(0xFFF5F5F5), // Fundo mais claro e limpo
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 201, 99, 3),
          centerTitle: true,
        ),
      ),
      initialRoute: '/welcome',
      routes: {
        '/': (context) => const HomePage(),
        '/perfil': (context) => ProfilePage(),
        '/artigos': (context) => NoticiasPage(),
        '/carteira_digital': (context) => CarteiraDigitalPage(),
        '/logout': (context) => LogoutPage(),
        '/settings': (context) => SettingsPage(),
        '/about': (context) => AboutPage(),
        '/notifications': (context) => NotificationsPage(),
        '/welcome': (context) => WelcomePage(),
      },
    );
  }
}
