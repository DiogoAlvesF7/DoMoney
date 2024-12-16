import 'package:flutter/material.dart';

class FiltroNoticiasPage extends StatefulWidget {
  final List<String> categoriasSelecionadas;

  const FiltroNoticiasPage(
      {super.key,
      required this.categoriasSelecionadas,
      required String categoriaSelecionada});

  @override
  State<FiltroNoticiasPage> createState() => _FiltroNoticiasPageState();
}

class _FiltroNoticiasPageState extends State<FiltroNoticiasPage> {
  final List<Map<String, dynamic>> categorias = [
    {"nome": "Economia", "selecionado": true},
    {"nome": "Ações", "selecionado": true},
    {"nome": "Criptomoedas", "selecionado": true},
    {"nome": "Investimentos", "selecionado": true},
    {"nome": "Mercado", "selecionado": true},
  ];

  @override
  void initState() {
    super.initState();
    // Inicializa categorias com as selecionadas do widget pai
    for (var categoria in categorias) {
      if (widget.categoriasSelecionadas.contains(categoria["nome"])) {
        categoria["selecionado"] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Filtrar Notícias",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Selecione os assuntos de notícias:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          // Lista de Categorias com Switches
          ...categorias.map((categoria) {
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  categoria["nome"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Switch(
                  value: categoria["selecionado"],
                  activeColor: Colors.black,
                  onChanged: (bool value) {
                    setState(() {
                      categoria["selecionado"] = value;
                    });
                  },
                ),
              ),
            );
          }).toList(),

          const SizedBox(height: 24),

          // Botão Salvar Preferências
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {
              _salvarPreferencias();
            },
            icon: const Icon(Icons.check),
            label: const Text("Salvar Preferências"),
          ),
        ],
      ),
    );
  }

  // Salva as preferências e retorna para a página anterior
  void _salvarPreferencias() {
    final selecionadas = categorias
        .where((categoria) => categoria["selecionado"] == true)
        .map((categoria) => categoria["nome"])
        .toList();

    Navigator.pop(context, selecionadas); // Retorna as categorias selecionadas
  }
}
