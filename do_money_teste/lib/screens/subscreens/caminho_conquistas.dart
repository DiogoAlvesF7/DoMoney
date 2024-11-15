import 'package:flutter/material.dart';

class CaminhoConquistas extends StatelessWidget {
  const CaminhoConquistas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caminho de Conquistas'),
        backgroundColor: const Color(0xFFFF9800),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: List.generate(5, (index) {
          return _buildModuleCard(index + 1);
        }),
      ),
    );
  }

  // Constrói cada módulo do Caminho de Conquistas
  Widget _buildModuleCard(int moduleNumber) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.star, color: Colors.orange, size: 30),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Módulo $moduleNumber', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(3, (i) {
                    // Estrelas preenchidas ou vazias de acordo com o progresso
                    return Icon(
                      Icons.star,
                      color: i < 2 ? Colors.orange : Colors.grey, // Exemplo com 2 estrelas preenchidas
                      size: 20,
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
