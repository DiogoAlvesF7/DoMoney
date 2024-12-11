import 'package:flutter/material.dart';

class LogoutPage extends StatelessWidget {
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
                // Ícone ou Ilustração
                const Icon(
                  Icons.exit_to_app,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 24),

                // Mensagem de Confirmação
                const Text(
                  "Deseja sair do DoMoney?",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Você precisará fazer login novamente para acessar o app.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Botões de Ação
                _buildActionButtons(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Botões Confirmar e Cancelar
  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // Botão Confirmar
        ElevatedButton(
          onPressed: () {
            // Lógica para sair do app
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/welcome', // Navega para a tela inicial
              (route) => false, // Remove todas as rotas anteriores
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            "Sair",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Botão Cancelar
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Volta para a página anterior
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            side: const BorderSide(color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            "Cancelar",
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
}
