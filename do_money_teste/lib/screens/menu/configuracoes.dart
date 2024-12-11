import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Configurações",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Configurações Gerais
          const SectionTitle(title: "Gerais"),
          SettingsTile(
            icon: Icons.language,
            title: "Idioma",
            onTap: () {
              // Ação para alterar idioma
            },
          ),
          SettingsTile(
            icon: Icons.brightness_6,
            title: "Tema",
            onTap: () {
              // Ação para alterar tema
            },
          ),
          SettingsTile(
            icon: Icons.notifications,
            title: "Notificações",
            onTap: () {
              // Ação para gerenciar notificações
            },
          ),

          const Divider(height: 32),

          // Configurações de Conta
          const SectionTitle(title: "Conta"),
          SettingsTile(
            icon: Icons.person,
            title: "Editar Informações Pessoais",
            onTap: () {
              // Ação para editar informações pessoais
            },
          ),
          SettingsTile(
            icon: Icons.lock,
            title: "Alterar Senha",
            onTap: () {
              // Ação para alterar senha
            },
          ),
          SettingsTile(
            icon: Icons.delete,
            title: "Excluir Conta",
            onTap: () {
              // Ação para excluir conta
            },
          ),

          const Divider(height: 32),

          // Informações do Aplicativo
          const SectionTitle(title: "Informações"),
          SettingsTile(
            icon: Icons.info,
            title: "Sobre o App",
            onTap: () {
              // Ação para exibir informações sobre o app
            },
          ),
          SettingsTile(
            icon: Icons.help,
            title: "Suporte",
            onTap: () {
              // Ação para acessar o suporte
            },
          ),
          SettingsTile(
            icon: Icons.description,
            title: "Termos de Uso",
            onTap: () {
              // Ação para exibir os termos de uso
            },
          ),
        ],
      ),
    );
  }
}

// Título de Seções
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}

// Tile de Configuração
class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
