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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: double.infinity),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Coluna se ajusta ao conteúdo
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Receita Média Destacada
            Container(
              width: screenWidth,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.orange, Colors.deepOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Receita Média",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "R\$ ${receitaMedia.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Baseada nos registros",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Transações Recentes (Carrossel Cascata)
            const Text(
              "Transações Recentes",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Usando shrinkWrap e ConstrainedBox no ListView
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true, // Permite que o ListView se ajuste
                itemCount: transacoesRecentes.length,
                itemBuilder: (context, index) {
                  final transacao = transacoesRecentes[index];
                  return _buildTransactionCard(
                    icon: transacao['icon'],
                    titulo: transacao['titulo'],
                    data: transacao['data'],
                    valor: transacao['valor'],
                    tipo: transacao['tipo'], // 'entrada' ou 'saída'
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionCard({
    IconData? icon, // Aceitar nullables
    required String titulo,
    required String data,
    required double valor,
    required String tipo,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Ícone da transação
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: tipo == "entrada" ? Colors.green[50] : Colors.red[50],
            ),
            child: Icon(
              icon ?? Icons.help_outline, // Usar ícone padrão se for null
              color: tipo == "entrada" ? Colors.green : Colors.red,
              size: 28,
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
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Valor da transação
          Text(
            "R\$ ${valor.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: tipo == "entrada" ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
