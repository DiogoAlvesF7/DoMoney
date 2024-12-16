import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo Gradiente
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.deepOrangeAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Conteúdo Principal
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                _buildLogo(),

                const SizedBox(height: 40),

                // Mensagem de Boas-Vindas
                const Text(
                  "Bem-vindo ao DoMoney!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Gerencie suas finanças e conquiste o sucesso financeiro.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Botões de Ação
                _buildActionButtons(context),

                const SizedBox(height: 20),

                // Rodapé
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Logo do App
  Widget _buildLogo() {
    return const Column(
      children: [
        // Substitua pelo logo real
        Icon(
          Icons.attach_money,
          size: 80,
          color: Colors.white,
        ),
        SizedBox(height: 8),
        Text(
          "DoMoney",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  // Botões de Login e Criar Conta
  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Navegar para a página de login
            Navigator.of(context).pushNamed('/');
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            "Entrar",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: () {
            // Navegar para a página de criação de conta
            Navigator.of(context).pushNamed('/signup');
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            side: const BorderSide(color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            "Criar Conta",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  // Rodapé com Termos e Suporte
  Widget _buildFooter() {
    return Column(
      children: [
        const Text(
          "Ao continuar, você concorda com nossos",
          style: TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () {
            // Link para termos de uso
          },
          child: const Text(
            "Termos de Uso e Política de Privacidade",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
