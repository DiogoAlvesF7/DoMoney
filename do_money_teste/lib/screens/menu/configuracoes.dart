import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Configurações",
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
            "Personalize sua experiência no DoMoney",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Modo Escuro
          _buildSwitchOption(
            context: context,
            title: "Modo Escuro",
            description: "Ative ou desative o tema escuro.",
            value: true, // Simular valor inicial
            onChanged: (bool value) {
              // Função para alternar o tema
            },
          ),

          // Configurações de Notificações
          _buildSwitchOption(
            context: context,
            title: "Notificações Push",
            description:
                "Receba alertas sobre investimentos, metas e notícias.",
            value: true, // Simular valor inicial
            onChanged: (bool value) {
              // Função para ativar/desativar notificações
            },
          ),

          // Idioma
          _buildListTileOption(
            context: context,
            title: "Idioma",
            description: "Escolha o idioma do app.",
            icon: Icons.language,
            onTap: () {
              // Abrir modal para selecionar idioma
            },
          ),

          // Segurança
          _buildListTileOption(
            context: context,
            title: "Segurança",
            description: "Gerencie sua senha e biometria.",
            icon: Icons.lock,
            onTap: () {
              // Abrir configurações de segurança
            },
          ),

          // Histórico de Login
          _buildListTileOption(
            context: context,
            title: "Histórico de Login",
            description: "Veja os dispositivos que acessaram sua conta.",
            icon: Icons.history,
            onTap: () {
              // Abrir página de histórico de login
            },
          ),

          // Sobre o App
          _buildListTileOption(
            context: context,
            title: "Sobre o DoMoney",
            description: "Saiba mais sobre o DoMoney.",
            icon: Icons.info_outline,
            onTap: () {
              // Abrir página "Sobre"
              Navigator.of(context).pushNamed('/about');
            },
          ),

          const Divider(color: Colors.white54),

          // Botão de Logout
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed('/logout');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            label: const Text(
              "Sair do DoMoney",
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

  // Opção com Toggle (Switch)
  Widget _buildSwitchOption({
    required BuildContext context,
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
          // Texto do Título e Descrição
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

  // Opção com Ícone
  Widget _buildListTileOption({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
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
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white54,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54),
        onTap: onTap,
      ),
    );
  }
}
