import 'package:flutter/material.dart';
import 'subscreens/balanco_financeiro/resumo_balanco.dart';
import 'subscreens/balanco_financeiro/graficos_despesas.dart';
import 'subscreens/balanco_financeiro/grafico_receitas.dart';

class BalancoFinanceiro extends StatefulWidget {
  const BalancoFinanceiro({super.key});

  @override
  _BalancoFinanceiroState createState() => _BalancoFinanceiroState();
}

class _BalancoFinanceiroState extends State<BalancoFinanceiro> {
  bool isDespesasSelected = true;

  final Map<String, double> despesas = {
    "Alimentação": 80.0,
    "Transporte": 50.0,
    "Saúde": 100.0,
    "Educação": 40.0,
    "Lazer": 30.0,
  };

  final Map<String, double> receitas = {
    "Salário": 3200.0,
    "Dividendos": 500.0,
    "Freelance": 300.0,
  };

  final List<Map<String, dynamic>> transacoesRecentes = [
    {
      "icon": Icons.attach_money,
      "titulo": "Salário",
      "data": "01/09/2024",
      "valor": 5000.00,
      "tipo": "entrada"
    },
    {
      "icon": Icons.shopping_cart,
      "titulo": "Supermercado",
      "data": "02/09/2024",
      "valor": 250.00,
      "tipo": "saída"
    },
    {
      "icon": Icons.home,
      "titulo": "Aluguel",
      "data": "03/09/2024",
      "valor": 100.00,
      "tipo": "saída"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Balanço Financeiro',
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Resumo do Balanço
            ResumoBalanco(
                receitaMedia: 3200, transacoesRecentes: transacoesRecentes),
            const SizedBox(height: 24),

            // Alternância entre "Despesas" e "Receitas"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildToggleButton(
                  label: "Receitas",
                  isSelected: isDespesasSelected == false,
                  onTap: () {
                    setState(() {
                      isDespesasSelected = false;
                    });
                  },
                  color: Colors.green, // Cor alinhada com o gráfico de receitas
                ),
                const SizedBox(width: 16),
                _buildToggleButton(
                  label: "Despesas",
                  isSelected: isDespesasSelected == true,
                  onTap: () {
                    setState(() {
                      isDespesasSelected = true;
                    });
                  },
                  color: Colors.red, // Cor alinhada com o gráfico de despesas
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Gráfico
            SizedBox(
              height: 500, // Altura fixa para evitar erro
              child: isDespesasSelected
                  ? GraficoDespesas(data: despesas)
                  : GraficoReceitas(data: receitas),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 2),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(2, 4),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
