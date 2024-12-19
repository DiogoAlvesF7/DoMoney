import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isLogin = true; // Controle de Login/Sign Up

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white, // Fundo branco para contraste
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Logo e Espaçamento
            const SizedBox(height: 50),
            _buildLogo(),
            const SizedBox(height: 30),

            // Alternância entre Login e Sign Up
            _buildTabSelector(),

            const SizedBox(height: 20),

            // Conteúdo: Formulário de Login ou Sign Up
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isLogin
                  ? _buildLoginForm(screenWidth)
                  : _buildSignUpForm(screenWidth),
            ),

            const SizedBox(height: 40),

            // Rodapé
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // Logo do DoMoney
  Widget _buildLogo() {
    return Column(
      children: [
        // Exemplo de logo (pode ser ajustado com uma imagem futuramente)
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.monetization_on,
            size: 48,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "DoMoney",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  // Alternância entre Login e Sign Up
  Widget _buildTabSelector() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _buildTabButton("Login", isLogin),
          _buildTabButton("Sign Up", !isLogin),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, bool isActive) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isLogin = title == "Login";
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? Colors.black : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  // Formulário de Login
  Widget _buildLoginForm(double width) {
    return Container(
      width: width * 0.9,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // E-mail
          const TextField(
            decoration: InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.email, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),

          // Senha
          const TextField(
            decoration: InputDecoration(
              labelText: "Senha",
              prefixIcon: Icon(Icons.lock, color: Colors.grey),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20),

          // Botão de Login
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text(
              "Entrar",
              style: TextStyle(fontSize: 16),
            ),
          ),

          const SizedBox(height: 12),

          // Link de Esqueci minha senha
          GestureDetector(
            onTap: () {
              // Ação para Esqueci minha senha
            },
            child: const Text(
              "Esqueci minha senha",
              style: TextStyle(color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }

  // Formulário de Sign Up
  Widget _buildSignUpForm(double width) {
    return Container(
      width: width * 0.9,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Nome
          const TextField(
            decoration: InputDecoration(
              labelText: "Nome completo",
              prefixIcon: Icon(Icons.person, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),

          // E-mail
          const TextField(
            decoration: InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.email, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),

          // Senha
          const TextField(
            decoration: InputDecoration(
              labelText: "Senha",
              prefixIcon: Icon(Icons.lock, color: Colors.grey),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20),

          // Botão de Sign Up
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text(
              "Criar conta",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Rodapé minimalista
  Widget _buildFooter() {
    return Column(
      children: const [
        Text(
          "Bem-vindo ao DoMoney",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Gerencie suas finanças com facilidade e eficiência.",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
