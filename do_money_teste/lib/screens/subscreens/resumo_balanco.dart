import 'package:flutter/material.dart';

class ResumoBalancoCarrossel extends StatelessWidget {
  final double receitaMedia;
  final List<Map<String, dynamic>> transacoesRecentes;

  const ResumoBalancoCarrossel({
    super.key,
    required this.receitaMedia,
    required this.transacoesRecentes,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Receita Média
          ReceitaMediaMensal(
            receitaMedia: receitaMedia,
            receitaTotal: 5000.00,
            crescimentoPercentual: 0.20,
            despesasTotais: 2000.00,
            width: screenWidth * 0.9, // Responsivo
          ),
          const SizedBox(height: 24),

          // Título das Transações Recentes
          const Text(
            "Transações Recentes",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          // Carrossel de Transações Recentes
          TransacoesCascata(transacoes: transacoesRecentes),
        ],
      ),
    );
  }
}

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Receita Média
          ReceitaMediaMensal(
            receitaMedia: receitaMedia,
            receitaTotal: 5000.00,
            crescimentoPercentual: 0.20,
            despesasTotais: 2000.00,
            width: screenWidth * 0.9, // Responsivo
          ),
          const SizedBox(height: 24),

          // Título das Transações Recentes
          const Text(
            "Transações Recentes",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          // Lista de Transações Recentes
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
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
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data,
                  style: const TextStyle(
                    fontSize: 12,
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
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: tipo == "entrada" ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class ReceitaMediaMensal extends StatelessWidget {
  final double receitaMedia;
  final double receitaTotal;
  final double crescimentoPercentual;
  final double despesasTotais;
  final double width;

  const ReceitaMediaMensal({
    super.key,
    required this.receitaMedia,
    required this.receitaTotal,
    required this.crescimentoPercentual,
    required this.despesasTotais,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Fundo Branco
        Container(
          width: width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Receita Média
              const Text(
                "Receita Média",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "R\$ ${receitaMedia.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[600],
                ),
              ),
              const SizedBox(height: 16),

              // Dados Complementares
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDataBlock(
                    title: "Receita Total",
                    value: "R\$ ${receitaTotal.toStringAsFixed(2)}",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: _buildDataBlock(
                      title: "Crescimento",
                      value:
                          "${crescimentoPercentual > 0 ? '+' : ''}${crescimentoPercentual.toStringAsFixed(1)}%",
                      valueColor:
                          crescimentoPercentual > 0 ? Colors.green : Colors.red,
                    ),
                  ),
                  _buildDataBlock(
                    title: "Despesas",
                    value: "R\$ ${despesasTotais.toStringAsFixed(2)}",
                    valueColor: Colors.redAccent,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDataBlock({
    required String title,
    required String value,
    Color valueColor = Colors.black,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

class TransacoesCascata extends StatefulWidget {
  final List<Map<String, dynamic>> transacoes;

  const TransacoesCascata({super.key, required this.transacoes});

  @override
  _TransacoesCascataState createState() => _TransacoesCascataState();
}

class _TransacoesCascataState extends State<TransacoesCascata> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.8, // Mostrar parcialmente os cards adjacentes
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // Altura total do carrossel
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical, // Configura a rolagem vertical
        itemCount: widget.transacoes.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          final transacao = widget.transacoes[index];
          final isCurrentPage = index == _currentPage;

          return Transform.scale(
            scale: isCurrentPage ? 1.0 : 0.9, // Destaque no card ativo
            child: _buildTransactionCard(
              icon: transacao['icon'],
              titulo: transacao['titulo'],
              data: transacao['data'],
              valor: transacao['valor'],
              tipo: transacao['tipo'], // 'entrada' ou 'saída'
              isActive: isCurrentPage,
            ),
          );
        },
      ),
    );
  }

  Widget _buildTransactionCard({
    IconData? icon,
    required String titulo,
    required String data,
    required double valor,
    required String tipo,
    required bool isActive,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey[100], // Fundo dinâmico
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: isActive ? 10 : 5,
            offset: const Offset(0, 4),
          ),
        ],
        border: isActive
            ? Border.all(color: Colors.orange, width: 2)
            : Border.all(color: Colors.transparent),
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
              icon ?? Icons.help_outline,
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
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data,
                  style: const TextStyle(
                    fontSize: 12,
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
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: tipo == "entrada" ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
