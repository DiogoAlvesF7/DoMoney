import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  final List<Map<String, String>> passos = [
    {
      "titulo": "Crie suas Metas",
      "descricao":
          "Defina metas financeiras, como economizar ou investir valores fictícios.",
    },
    {
      "titulo": "Simule Investimentos",
      "descricao":
          "Escolha entre ações, criptomoedas ou renda fixa e veja os resultados fictícios.",
    },
    {
      "titulo": "Desbloqueie Conquistas",
      "descricao":
          "Alcance marcos importantes, como completar uma meta ou atingir XP máximo.",
    },
    {
      "titulo": "Progrida na Carreira",
      "descricao":
          "Ganhe XP, suba de nível e alcance cargos como Diretor Financeiro no mundo DoMoney.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Como Jogar",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            const Text(
              "Bem-vindo ao DoMoney!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              "Aprenda a gerenciar suas finanças de forma divertida e educativa. Aqui está como você pode começar:",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),

            // Lista de Passos
            ...passos.map((passo) => _buildStepCard(passo)).toList(),

            const SizedBox(height: 24),

            // Rodapé Motivacional
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  // Card de cada passo
  Widget _buildStepCard(Map<String, String> passo) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Título e Descrição
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    passo["titulo"]!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    passo["descricao"]!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
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

  // Rodapé Motivacional
  Widget _buildFooter(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            "Pronto para começar sua jornada financeira?",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Navegar para a página principal
              Navigator.of(context).pushReplacementNamed('/');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            ),
            child: const Text(
              "Começar Agora",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
