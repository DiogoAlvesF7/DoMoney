import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BalancoFinanceiro extends StatefulWidget {
  const BalancoFinanceiro({super.key});

  @override
  _FinancialSummaryState createState() => _FinancialSummaryState();
}

class _FinancialSummaryState extends State<BalancoFinanceiro> {
  bool showIncomeDetails = false;
  bool showExpenseDetails = false;

  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _showOverlay(
      BuildContext context, List<Transaction> transactions, Offset offset) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: transactions
                  .map((tx) => ListTile(
                        leading: Icon(
                          tx.type == TransactionType.income
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: tx.type == TransactionType.income
                              ? Colors.green
                              : Colors.red,
                        ),
                        title: Text(tx.description),
                        subtitle: Text(tx.date),
                        trailing: Text(
                          'R\$ ${tx.amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: tx.type == TransactionType.income
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    // Dados fictícios para demonstração
    final incomeTransactions = [
      Transaction('Salário', '01/09/2024', 5000.00, TransactionType.income),
      Transaction('Freelance', '15/08/2024', 1200.00, TransactionType.income),
      Transaction('Venda', '10/08/2024', 800.00, TransactionType.income),
      Transaction('Dividendos', '05/08/2024', 300.00, TransactionType.income),
      Transaction('Reembolso', '25/07/2024', 150.00, TransactionType.income),
    ];

    final expenseTransactions = [
      Transaction(
          'Supermercado', '02/09/2024', 250.00, TransactionType.expense),
      Transaction('Aluguel', '01/09/2024', 1200.00, TransactionType.expense),
      Transaction('Academia', '31/08/2024', 100.00, TransactionType.expense),
      Transaction('Internet', '29/08/2024', 80.00, TransactionType.expense),
      Transaction('Restaurante', '28/08/2024', 60.00, TransactionType.expense),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resumo Financeiro',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balanço Financeiro
            FinancialBalance(
              income: 7450.00,
              expenses: 1690.00,
              incomeTransactions: incomeTransactions,
              expenseTransactions: expenseTransactions,
            ),
            const SizedBox(height: 30),

            // Gastos por Segmento
            const Text(
              'Gastos por Segmento',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SpendingCharts(),
            const SizedBox(height: 30),

            // Botão para Registros Financeiros
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navegar para a página de registros financeiros
                },
                icon: const Icon(
                  Icons.list_alt,
                  size: 24,
                  color: Colors.white,
                ),
                label: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  child: Text(
                    'Ver Registros Financeiros',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FinancialBalance extends StatefulWidget {
  final double income;
  final double expenses;
  final List<Transaction> incomeTransactions;
  final List<Transaction> expenseTransactions;

  const FinancialBalance({
    super.key,
    required this.income,
    required this.expenses,
    required this.incomeTransactions,
    required this.expenseTransactions,
  });

  @override
  _FinancialBalanceState createState() => _FinancialBalanceState();
}

class _FinancialBalanceState extends State<FinancialBalance> {
  OverlayEntry? _overlayEntry;

  void _showTransactions(
      List<Transaction> transactions, BuildContext context, Offset offset) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        right: 300,
        top: 20,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: transactions
                  .map((tx) => ListTile(
                        leading: Icon(
                          tx.type == TransactionType.income
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: tx.type == TransactionType.income
                              ? Colors.green
                              : Colors.red,
                        ),
                        title: Text(tx.description),
                        subtitle: Text(tx.date),
                        trailing: Text(
                          'R\$ ${tx.amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: tx.type == TransactionType.income
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    double balance = widget.income - widget.expenses;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          // Saldo Total
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Saldo Total',
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  'R\$ ${balance.toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // Entradas e Saídas
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Entradas
              MouseRegion(
                onEnter: (event) => _showTransactions(
                    widget.incomeTransactions, context, event.position),
                onExit: (event) => _removeOverlay(),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_upward,
                        color: Colors.green, size: 28),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Entradas',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        Text(
                          'R\$ ${widget.income.toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Saídas
              MouseRegion(
                onEnter: (event) => _showTransactions(
                    widget.expenseTransactions, context, event.position),
                onExit: (event) => _removeOverlay(),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_downward,
                        color: Colors.red, size: 28),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Saídas',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        Text(
                          'R\$ ${widget.expenses.toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SpendingCharts extends StatelessWidget {
  // Dados fictícios para os gráficos
  final Map<String, double> spendingByCategory = {
    'Alimentação': 500.00,
    'Transporte': 200.00,
    'Entretenimento': 150.00,
    'Saúde': 100.00,
    'Educação': 80.00,
  };

  SpendingCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Gráfico de Pizza
        Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: spendingByCategory.entries.map((entry) {
                final percentage = (entry.value /
                        spendingByCategory.values.reduce((a, b) => a + b)) *
                    100;
                return PieChartSectionData(
                  color: _getRandomColor(),
                  value: entry.value,
                  title: '${percentage.toStringAsFixed(1)}%',
                  radius: 60,
                  titleStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Gráfico de Barras
        Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 600,
              barTouchData: BarTouchData(enabled: true),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      final category =
                          spendingByCategory.keys.elementAt(value.toInt());
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(category,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      );
                    },
                    reservedSize: 30,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      return Text(
                        'R\$ ${value.toStringAsFixed(0)}',
                        style: const TextStyle(color: Colors.black),
                      );
                    },
                    interval: 100,
                    reservedSize: 40,
                  ),
                ),
              ),
              gridData: const FlGridData(show: true),
              borderData: FlBorderData(show: false),
              barGroups: spendingByCategory.entries.map((entry) {
                return BarChartGroupData(
                  x: spendingByCategory.keys.toList().indexOf(entry.key),
                  barRods: [
                    BarChartRodData(
                      toY: entry.value,
                      color: _getRandomColor(),
                      width: 20,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Color _getRandomColor() {
    return Color(
        (0xFF000000 + (0xFFFFFF * (spendingByCategory.length * 0.1)).toInt()));
  }
}

enum TransactionType { income, expense }

class Transaction {
  final String description;
  final String date;
  final double amount;
  final TransactionType type;

  Transaction(this.description, this.date, this.amount, this.type);
}
