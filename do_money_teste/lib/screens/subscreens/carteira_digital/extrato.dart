import 'package:flutter/material.dart';

class ExtratoPage extends StatefulWidget {
  const ExtratoPage({super.key});

  @override
  _ExtratoPageState createState() => _ExtratoPageState();
}

class _ExtratoPageState extends State<ExtratoPage> {
  String _filtroSelecionado = "Ações";

  // Dados fictícios da carteira
  final Map<String, List<Map<String, dynamic>>> _investimentos = {
    "Ações": [
      {
        "nome": "PETR4",
        "empresa": "Petrobras",
        "valorInvestido": 12000.00, // Histórico de valor investido
        "valorAtual": 11856.00, // Valor atual da ação no total
        "valorizacao": -1.2,
        "precoAtual": 30.00,
        "variacaoPreco": -0.5, // Variação diária do preço
        "quantidade": 400,
        "imagem":
            "https://assets.hgbrasil.com/finance/companies/big/petrobras.png",
      },
      {
        "nome": "VALE3",
        "empresa": "Vale S.A.",
        "valorInvestido": 15000.00,
        "valorAtual": 15420.00,
        "valorizacao": 2.8,
        "precoAtual": 65.00,
        "variacaoPreco": 0.3,
        "quantidade": 230,
        "imagem": "https://static.cdnlogo.com/logos/v/1/vale.png",
      },
    ],
    "CDB": [
      {
        "nome": "CDB XP",
        "empresa": "Banco XP",
        "valorInvestido": 10000.00,
        "valorAtual": 10000.00,
        "valorizacao": 0.5,
        "precoAtual": 10000.00,
        "variacaoPreco": 0.0,
        "quantidade": 1,
        "imagem":
            "https://upload.wikimedia.org/wikipedia/pt/0/0b/XP_Investimentos_logo.png",
      },
    ],
    "Selic": [
      {
        "nome": "Tesouro Selic",
        "empresa": "Tesouro Nacional",
        "valorInvestido": 5000.00,
        "valorAtual": 5000.00,
        "valorizacao": 0.3,
        "precoAtual": 5000.00,
        "variacaoPreco": 0.0,
        "quantidade": 1,
        "imagem": "https://static.poder360.com.br/2020/07/tesouro-selic.png",
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final investimentosFiltrados = _investimentos[_filtroSelecionado] ?? [];
    final valorTotalCategoria = investimentosFiltrados.fold<double>(
      0.0,
      (soma, item) => soma + item["valorAtual"],
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Center(
              child: Text(
                "Extrato da Carteira",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Filtro horizontal
          _buildFiltroHorizontal(),

          const SizedBox(height: 16),
          // Resumo do Valor Total
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Valor Total:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "R\$ ${valorTotalCategoria.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Lista de Investimentos
          Expanded(
            child: ListView.builder(
              itemCount: investimentosFiltrados.length,
              itemBuilder: (context, index) {
                final item = investimentosFiltrados[index];
                return _buildInvestimentoItem(item, valorTotalCategoria);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Filtro Horizontal
  Widget _buildFiltroHorizontal() {
    final categorias = _investimentos.keys.toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: categorias.map((categoria) {
          final bool isSelected = _filtroSelecionado == categoria;

          return GestureDetector(
            onTap: () {
              setState(() {
                _filtroSelecionado = categoria;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange : Colors.grey[850],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                categoria,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.black : Colors.white70,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Item de Investimento
  Widget _buildInvestimentoItem(
      Map<String, dynamic> item, double totalCarteira) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Linha superior: Nome, empresa e valor total
          Row(
            children: [
              // Imagem
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item["imagem"] ?? "https://via.placeholder.com/50",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              // Nome e empresa
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["nome"],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      item["empresa"],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              // Preço Atual
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "R\$ ${item["precoAtual"].toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${item["variacaoPreco"] >= 0 ? '+' : ''}${item["variacaoPreco"].toStringAsFixed(2)}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: item["variacaoPreco"] >= 0
                          ? Colors.greenAccent
                          : Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(color: Colors.white54),
          // Linha inferior: Investido e Valor Atual
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfo("Quantidade", item["quantidade"].toString()),
              _buildInfo("Valor Investido",
                  "R\$ ${item["valorInvestido"].toStringAsFixed(2)}"),
              _buildInfo(
                "Montante Atual",
                "R\$ ${item["valorAtual"].toStringAsFixed(2)}",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
