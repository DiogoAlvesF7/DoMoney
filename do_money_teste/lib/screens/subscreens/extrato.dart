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
        "valorTotal": 11856.00,
        "valorizacao": -1.2,
        "precoAtual": 30.00,
        "quantidade": 400,
        "imagem":
            "https://assets.hgbrasil.com/finance/companies/big/petrobras.png" // Placeholder
      },
      {
        "nome": "VALE3",
        "empresa": "Vale S.A.",
        "valorTotal": 15420.00,
        "valorizacao": 2.8,
        "precoAtual": 65.00,
        "quantidade": 230,
        "imagem": "https://static.cdnlogo.com/logos/v/1/vale.png"
      },
    ],
    "CDB": [
      {
        "nome": "CDB XP",
        "empresa": "Banco XP",
        "valorTotal": 10000.00,
        "valorizacao": 0.5,
        "precoAtual": 10000.00,
        "quantidade": 1,
        "imagem":
            "https://upload.wikimedia.org/wikipedia/pt/0/0b/XP_Investimentos_logo.png"
      },
    ],
    "Selic": [
      {
        "nome": "Tesouro Selic",
        "empresa": "Tesouro Nacional",
        "valorTotal": 5000.00,
        "valorizacao": 0.3,
        "precoAtual": 5000.00,
        "quantidade": 1,
        "imagem": "https://static.poder360.com.br/2020/07/tesouro-selic.png"
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final investimentosFiltrados = _investimentos[_filtroSelecionado] ?? [];
    final valorTotalCategoria = investimentosFiltrados.fold<double>(
      0.0,
      (soma, item) => soma + item["valorTotal"],
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
                    fontSize: 20),
              ),
            ),
          ),
          // Filtro de categorias
          _buildFiltroCategorias(),

          // Valor Total da Categoria
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Valor Total: R\$ ${valorTotalCategoria.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          // Lista de investimentos
          Expanded(
            child: ListView.builder(
              itemCount: investimentosFiltrados.length,
              itemBuilder: (context, index) {
                final item = investimentosFiltrados[index];
                return _buildInvestimentoItem(item);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Filtro de categorias (DropdownButton)
  Widget _buildFiltroCategorias() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButton<String>(
        dropdownColor: Colors.grey[900],
        value: _filtroSelecionado,
        style: const TextStyle(color: Colors.white),
        isExpanded: true,
        underline: Container(),
        items: _investimentos.keys.map((String categoria) {
          return DropdownMenuItem<String>(
            value: categoria,
            child: Text(
              categoria,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _filtroSelecionado = newValue!;
          });
        },
      ),
    );
  }

  // Item de Investimento
  Widget _buildInvestimentoItem(Map<String, dynamic> item) {
    final bool isPositivo = item["valorizacao"] >= 0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Linha superior: Ícone, nome da ação e valor total com valorização
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Imagem da ação
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

              // Nome da ação e empresa
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

              // Valor total e valorização
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "R\$ ${item["valorTotal"].toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        isPositivo ? Icons.arrow_upward : Icons.arrow_downward,
                        size: 14,
                        color:
                            isPositivo ? Colors.greenAccent : Colors.redAccent,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${isPositivo ? '+' : ''}${item["valorizacao"].toStringAsFixed(2)}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isPositivo
                              ? Colors.greenAccent
                              : Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Linha inferior: Preço atual, quantidade e total
          Divider(color: Colors.white12, height: 1),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfo("Preço atual",
                  "R\$ ${item["precoAtual"].toStringAsFixed(2)}"),
              _buildInfoWithIcon(
                "Quantidade",
                "${item["quantidade"]}",
                Icons.confirmation_number_outlined,
              ),
              _buildInfo("Investimento",
                  "R\$ ${item["valorTotal"].toStringAsFixed(2)}"),
            ],
          ),
        ],
      ),
    );
  }

// Informações simples
  Widget _buildInfo(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
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

// Informações com ícone
  Widget _buildInfoWithIcon(String title, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(icon, color: Colors.amberAccent, size: 14),
            const SizedBox(width: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
