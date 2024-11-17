import 'package:flutter/material.dart';

class DoMoneySimulation extends StatefulWidget {
  const DoMoneySimulation({super.key});

  @override
  _DoMoneySimulationState createState() => _DoMoneySimulationState();
}

class _DoMoneySimulationState extends State<DoMoneySimulation> {
  final List<Map<String, dynamic>> _modulos = [
    {"nome": "Introdução ao DoMoney", "progresso": 0.3, "completo": false},
    {"nome": "Gestão de Gastos", "progresso": 0.8, "completo": false},
    {"nome": "Investimentos Básicos", "progresso": 1.0, "completo": true},
    {"nome": "Planejamento Financeiro", "progresso": 0.6, "completo": false},
    {"nome": "Simulação Avançada", "progresso": 0.0, "completo": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prédio DoMoney',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Módulos Disponíveis",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _modulos.length,
                itemBuilder: (context, index) {
                  final modulo = _modulos[index];
                  return _buildModuloCard(
                    nome: modulo['nome'],
                    progresso: modulo['progresso'],
                    completo: modulo['completo'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () => _showSettingsModal(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModuloCard({
    required String nome,
    required double progresso,
    required bool completo,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(nome, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progresso,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                completo ? Colors.green : Colors.orange,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              completo
                  ? "Concluído"
                  : "Progresso: ${(progresso * 100).toInt()}%",
              style: TextStyle(
                color: completo ? Colors.green : Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: Icon(
          completo ? Icons.check_circle : Icons.arrow_forward,
          color: completo ? Colors.green : Colors.grey,
        ),
        onTap: completo
            ? null
            : () {
                // Aqui será implementada a lógica para abrir o módulo
                _abrirModulo(nome);
              },
      ),
    );
  }

  void _abrirModulo(String nome) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Abrindo módulo: $nome')),
    );
  }

  void _showSettingsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '⚙️ Configurações',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Divider(),
              ElevatedButton(
                onPressed: () => _reiniciarSimulacao(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: const Text('Reiniciar Simulação',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _reiniciarSimulacao() {
    setState(() {
      for (var modulo in _modulos) {
        modulo['progresso'] = 0.0;
        modulo['completo'] = false;
      }
    });
    Navigator.pop(context); // Fecha o modal
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Simulação reiniciada!')),
    );
  }
}
