import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Tooltip(
          message: 'Voltar',
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.black,
        title: const Text(
          "Introdução",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Título principal
            const Text(
              "Bem-vindo ao DoMoney!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // Descrição inicial
            const Text(
              "O DoMoney é um aplicativo que combina elementos educativos e gamificação para ajudá-lo a tornar-se um indivíduo economicamente educado enquanto se diverte. Confira como aproveitar ao máximo cada funcionalidade:",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),

            // Funcionalidade: Balanço Financeiro
            _buildFeatureCard(
              icon: Icons.pie_chart_outline,
              title: "Balanço Financeiro",
              description:
                  "Acompanhe suas finanças reais com gráficos intuitivos e resumos detalhados. Veja receitas, despesas e metas alcançadas.",
              onTap: () {
                // Navegar para a página de Balanço Financeiro
              },
            ),

            // Funcionalidade: Carteira Digital
            _buildFeatureCard(
              icon: Icons.account_balance_wallet_outlined,
              title: "Carteira Digital",
              description:
                  "Simule investimentos fictícios baseados em dados reais do mercado financeiro. Experimente ações, CDBs, e mais.",
              onTap: () {
                // Navegar para a página de Carteira Digital
              },
            ),

            // Funcionalidade: Notícias
            _buildFeatureCard(
              icon: Icons.newspaper_outlined,
              title: "Notícias",
              description:
                  "Mantenha-se atualizado com as principais notícias do mercado financeiro, personalizadas de acordo com suas preferências.",
              onTap: () {
                // Navegar para a página de Notícias
              },
            ),

            // Funcionalidade: Metas Financeiras
            _buildFeatureCard(
              icon: Icons.flag_outlined,
              title: "Metas Financeiras",
              description:
                  "Defina e acompanhe suas metas financeiras pessoais de forma prática e motivadora.",
              onTap: () {
                // Navegar para a página de Metas
              },
            ),

            // Funcionalidade: Gamificação
            _buildFeatureCard(
              icon: Icons.emoji_events_outlined,
              title: "Gamificação",
              description:
                  "Complete missões, ganhe conquistas e suba de nível enquanto aprende sobre finanças e alcança suas metas.",
              onTap: () {
                // Navegar para a página de Gamificação
              },
            ),

            // Funcionalidade: Suporte
            _buildFeatureCard(
              icon: Icons.help_outline,
              title: "Suporte",
              description:
                  "Precisa de ajuda? Acesse nossa central de suporte ou entre em contato diretamente pelo aplicativo.",
              onTap: () {
                // Navegar para a página de Suporte
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget para os cards de funcionalidades
  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Ícone
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange.withOpacity(0.2),
              ),
              child: Icon(
                icon,
                size: 28,
                color: Colors.orange,
              ),
            ),
            const SizedBox(width: 16),

            // Texto do card
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      height: 1.5,
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
}
