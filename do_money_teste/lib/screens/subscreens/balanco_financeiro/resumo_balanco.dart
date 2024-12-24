import 'package:flutter/material.dart';

class ResumoBalanco extends StatelessWidget {
  final double receitaMedia;
  final List<Map<String, dynamic>> transacoesRecentes;

  const ResumoBalanco({
    super.key,
    required this.receitaMedia,
    required this.transacoesRecentes,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Receita Média - Centralizado e Compacto
        Center(
          child: Container(
            width: screenWidth * 0.9,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  "Receita Média",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "R\$ ${receitaMedia.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(color: Colors.white12, thickness: 1),
                const Text("Neste mês",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildResumoItem(
                      title: "Receitas",
                      value: "R\$ 5000.00",
                      color: Colors.white70,
                    ),
                    _buildResumoItem(
                      title: "Crescimento",
                      value: "+0.2%",
                      color: Colors.greenAccent,
                    ),
                    _buildResumoItem(
                      title: "Despesas",
                      value: "R\$ 2000.00",
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Transações Recentes - Lista Compacta
        const Text(
          "Transações Recentes",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: transacoesRecentes.length,
          itemBuilder: (context, index) {
            final transacao = transacoesRecentes[index];
            return _buildTransactionCard(
              icon: transacao['icon'],
              titulo: transacao['titulo'],
              data: transacao['data'],
              valor: transacao['valor'],
              tipo: transacao['tipo'],
            );
          },
        ),
      ],
    );
  }

  Widget _buildResumoItem({
    required String title,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionCard({
    IconData? icon,
    required String titulo,
    required String data,
    required double valor,
    required String tipo,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: tipo == "entrada" ? Colors.green : Colors.red,
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Ícone da transação
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: tipo == "entrada" ? Colors.green[50] : Colors.red[50],
            ),
            child: Icon(
              icon ?? Icons.help_outline,
              color: tipo == "entrada" ? Colors.green : Colors.red,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),

          // Detalhes da transação
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // Valor da transação
          Text(
            "R\$ ${valor.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: tipo == "entrada" ? Colors.greenAccent : Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
