import 'package:flutter/material.dart';

class FiltroNoticiasPage extends StatefulWidget {
  final List<String> categoriasSelecionadas;

  const FiltroNoticiasPage({
    super.key,
    required this.categoriasSelecionadas,
    required String categoriaSelecionada,
  });

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
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Escolha os temas de notícias",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text("do seu interesse:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Lista de Categorias com Switches
            Expanded(
              child: ListView.builder(
                itemCount: categorias.length,
                itemBuilder: (context, index) {
                  final categoria = categorias[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: categoria["selecionado"]
                            ? Colors.orange
                            : Colors.grey[700]!,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          categoria["nome"],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Switch(
                          value: categoria["selecionado"],
                          activeColor: Colors.orange,
                          inactiveThumbColor: Colors.grey,
                          onChanged: (bool value) {
                            setState(() {
                              categoria["selecionado"] = value;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Botão Salvar Preferências
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    _salvarPreferencias();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check, size: 24),
                      SizedBox(width: 8),
                      Text(
                        "Aplicar Filtros",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _salvarPreferencias() {
    final selecionadas = categorias
        .where((categoria) => categoria["selecionado"] == true)
        .map((categoria) => categoria["nome"])
        .toList();

    Navigator.pop(context, selecionadas);
  }
}
