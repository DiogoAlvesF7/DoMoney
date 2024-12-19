import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Notificações",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          // Título
          const Text(
            "Gerencie suas notificações",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Notificações de Notícias
          _buildSwitchOption(
            title: "Notícias Financeiras",
            description:
                "Receba alertas sobre as principais notícias relacionadas ao universo financeiro.",
            value: true,
            onChanged: (bool value) {
              // Função para ativar/desativar notificações de notícias
            },
          ),

          // Notificações de Investimentos
          _buildSwitchOption(
            title: "Atualizações de Investimentos",
            description:
                "Seja notificado sobre variações na sua carteira digital.",
            value: false,
            onChanged: (bool value) {
              // Função para ativar/desativar notificações de investimentos
            },
          ),

          // Notificações de Metas
          _buildSwitchOption(
            title: "Progresso de Metas",
            description:
                "Receba lembretes e conquistas relacionadas às suas metas e ao seu progresso no Prédio DoMoney.",
            value: true,
            onChanged: (bool value) {
              // Função para ativar/desativar notificações de metas
            },
          ),

          // Notificações de Alertas do Sistema
          _buildSwitchOption(
            title: "Alertas do Sistema",
            description: "Fique por dentro de atualizações e mudanças no app.",
            value: true,
            onChanged: (bool value) {
              // Função para ativar/desativar notificações do sistema
            },
          ),

          const Divider(color: Colors.white54),

          // Botão de Gerenciar Notificações
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              // Ação ao clicar no botão
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.notifications_active, color: Colors.white),
            label: const Text(
              "Configurações Avançadas",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget para Switch (Toggle)
  Widget _buildSwitchOption({
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Texto de Título e Descrição
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.orange,
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey[700],
          ),
        ],
      ),
    );
  }
}
