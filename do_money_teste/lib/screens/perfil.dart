import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String nomeUsuario = "Diogo Ferreira";
  final String fotoPerfil =
      "https://via.placeholder.com/150"; // URL da imagem de perfil
  final String cargoAtual = "Gerente Financeiro";
  final double salarioAtual = 12500.00; // Salário fictício
  final List<Map<String, dynamic>> conquistas = [
    {"titulo": "Primeiro Investimento", "descricao": "Investiu pela 1ª vez."},
    {"titulo": "Meta Atingida", "descricao": "Concluiu uma meta financeira."},
    {"titulo": "XP Máximo", "descricao": "Alcançou 1000 XP em um mês."},
  ];
  final List<String> amigos = ["Ana", "Carlos", "Laura", "Bruno"];
  final List<Map<String, dynamic>> metas = [
    {"meta": "Economizar R\$ 5000", "status": "Concluída"},
    {"meta": "Investir R\$ 2000", "status": "Em Progresso"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Perfil",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header do Perfil
            _buildHeader(),
            const SizedBox(height: 24),

            // Conquistas
            _buildConquistas(),
            const SizedBox(height: 24),

            // Metas de Investimento
            _buildMetas(),
            const SizedBox(height: 24),

            // Amigos no App
            _buildAmigos(),
          ],
        ),
      ),
    );
  }

  // Header do Perfil
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.orange, Colors.deepOrangeAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Foto do Usuário
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(fotoPerfil),
          ),
          const SizedBox(height: 16),

          // Nome e Cargo Atual
          Text(
            nomeUsuario,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            cargoAtual,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 16),

          // Salário Atual
          Text(
            "Salário Atual: R\$ ${salarioAtual.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Conquistas
  Widget _buildConquistas() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Conquistas",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...conquistas.map((conquista) {
          return ListTile(
            leading: const Icon(Icons.star, color: Colors.orange),
            title: Text(
              conquista["titulo"],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(conquista["descricao"]),
          );
        }).toList(),
      ],
    );
  }

  // Metas de Investimento
  Widget _buildMetas() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Metas de Investimento",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...metas.map((meta) {
          return ListTile(
            leading: const Icon(Icons.flag, color: Colors.orange),
            title: Text(
              meta["meta"],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              meta["status"],
              style: TextStyle(
                color: meta["status"] == "Concluída"
                    ? Colors.green
                    : Colors.orange,
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  // Amigos no App
  Widget _buildAmigos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Amigos no App",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: amigos.map((amigo) {
            return Chip(
              label: Text(amigo),
              avatar: const Icon(Icons.person, color: Colors.white),
              backgroundColor: Colors.orange,
              labelStyle: const TextStyle(color: Colors.white),
            );
          }).toList(),
        ),
      ],
    );
  }
}
