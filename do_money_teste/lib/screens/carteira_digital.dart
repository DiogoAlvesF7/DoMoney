import 'package:flutter/material.dart';

class CarteiraDigitalPage extends StatefulWidget {
  const CarteiraDigitalPage({super.key});

  @override
  _CarteiraDigitalPageState createState() => _CarteiraDigitalPageState();
}

class _CarteiraDigitalPageState extends State<CarteiraDigitalPage> {
  double _totalInvestido = 15000.00;
  double _retornoGeral = 12.5; // Em percentual
  double _metaInvestimento = 20000.00;
  List<Map<String, dynamic>> _investimentos = [
    {
      "nome": "Ação XPTO",
      "valorAtual": 120.0,
      "retorno": 8.2, // Em percentual
      "categoria": "Ações",
    },
    {
      "nome": "Criptomoeda XYZ",
      "valorAtual": 0.0021,
      "retorno": 15.0,
      "categoria": "Criptomoedas",
    },
    {
      "nome": "CDB Alpha",
      "valorAtual": 1050.0,
      "retorno": 5.1,
      "categoria": "CDB",
    },
  ];

  List<Map<String, dynamic>> _transacoes = [
    {"data": "01/09/2024", "descricao": "Compra de Ações", "valor": -2000.00},
    {"data": "05/09/2024", "descricao": "Venda de Cripto", "valor": 500.00},
    {"data": "10/09/2024", "descricao": "Compra de CDB", "valor": -1000.00},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carteira Digital',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resumo da Carteira
            _buildResumoCarteira(),
            const SizedBox(height: 24),

            // Meta de Investimento
            _buildMetaInvestimento(),
            const SizedBox(height: 24),

            // Carteira de Investimentos
            _buildCarteiraInvestimentos(),
            const SizedBox(height: 24),

            // Histórico de Transações
            _buildHistoricoTransacoes(),
          ],
        ),
      ),
    );
  }

  // Resumo da Carteira
  Widget _buildResumoCarteira() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.orange, Colors.deepOrangeAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Resumo da Carteira",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Total Investido: R\$ ${_totalInvestido.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Retorno Geral: ${_retornoGeral.toStringAsFixed(1)}%",
            style: TextStyle(
              fontSize: 16,
              color: _retornoGeral >= 0 ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Meta de Investimento
  Widget _buildMetaInvestimento() {
    double progresso = _totalInvestido / _metaInvestimento;
    progresso = progresso > 1.0 ? 1.0 : progresso;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Meta de Investimento",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progresso,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
            const SizedBox(height: 16),
            Text(
              "Progresso: ${(progresso * 100).toStringAsFixed(1)}%",
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // Carteira de Investimentos
  Widget _buildCarteiraInvestimentos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Carteira de Investimentos",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ..._investimentos.map((investimento) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(
                Icons.trending_up,
                color: investimento['retorno'] >= 0 ? Colors.green : Colors.red,
              ),
              title: Text(investimento['nome']),
              subtitle: Text("Categoria: ${investimento['categoria']}"),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "R\$ ${investimento['valorAtual'].toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${investimento['retorno'].toStringAsFixed(1)}%",
                    style: TextStyle(
                      color: investimento['retorno'] >= 0
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  // Histórico de Transações
  Widget _buildHistoricoTransacoes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Histórico de Transações",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ..._transacoes.map((transacao) {
          return ListTile(
            leading: Icon(
              transacao['valor'] >= 0
                  ? Icons.arrow_upward
                  : Icons.arrow_downward,
              color: transacao['valor'] >= 0 ? Colors.green : Colors.red,
            ),
            title: Text(transacao['descricao']),
            subtitle: Text(transacao['data']),
            trailing: Text(
              "R\$ ${transacao['valor'].toStringAsFixed(2)}",
              style: TextStyle(
                color: transacao['valor'] >= 0 ? Colors.green : Colors.red,
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
