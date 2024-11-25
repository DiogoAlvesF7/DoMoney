import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BalancoFinanceiro extends StatefulWidget {
  const BalancoFinanceiro({super.key});

  @override
  _BalancoFinanceiroState createState() => _BalancoFinanceiroState();
}

class _BalancoFinanceiroState extends State<BalancoFinanceiro> {
  bool isPieChart = true; // Alternar entre gráfico de setores e de linhas

  // Dados fictícios para demonstração
  final Map<String, double> spendingByCategory = {
    'Alimentação': 500.00,
    'Transporte': 200.00,
    'Entretenimento': 150.00,
    'Saúde': 100.00,
    'Educação': 80.00,
  };

  final Map<String, List<Transaction>> detailedTransactions = {
    'Alimentação': [
      Transaction('Mercado', '01/11/2024', 200.00, TransactionType.expense),
      Transaction('Lanchonete', '03/11/2024', 50.00, TransactionType.expense),
      Transaction('Jantar', '05/11/2024', 250.00, TransactionType.expense),
    ],
    'Transporte': [
      Transaction('Combustível', '02/11/2024', 150.00, TransactionType.expense),
      Transaction('Ônibus', '04/11/2024', 50.00, TransactionType.expense),
    ],
  };

  void _showSegmentDetails(String segment) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final transactions = detailedTransactions[segment] ?? [];
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detalhes: $segment',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...transactions.map((tx) {
                return ListTile(
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
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Balanço Financeiro',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Alternar entre tipos de gráficos
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => isPieChart = true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isPieChart ? Colors.black : Colors.grey[300],
                  ),
                  child: const Text('Setores',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => setState(() => isPieChart = false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        !isPieChart ? Colors.black : Colors.grey[300],
                  ),
                  child: const Text('Linhas',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Exibir o gráfico atual
            Expanded(
              child: isPieChart ? _buildPieChart() : _buildLineChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: spendingByCategory.entries.map((entry) {
          final percentage = (entry.value /
                  spendingByCategory.values.reduce((a, b) => a + b)) *
              100;
          return PieChartSectionData(
            color: Colors.primaries[
                spendingByCategory.keys.toList().indexOf(entry.key) %
                    Colors.primaries.length],
            value: entry.value,
            title: '${percentage.toStringAsFixed(1)}%',
            radius: 60,
            titleStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            badgeWidget: GestureDetector(
              onTap: () => _showSegmentDetails(entry.key),
              child: const Icon(Icons.info, color: Colors.white, size: 16),
            ),
            badgePositionPercentageOffset: 1.2,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: spendingByCategory.entries
                .toList()
                .asMap()
                .entries
                .map((entry) => FlSpot(entry.key.toDouble(), entry.value.value))
                .toList(),
            isCurved: true,
            barWidth: 4,
            color: Colors.blue,
            belowBarData:
                BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 100,
              getTitlesWidget: (value, _) => Text(
                'R\$ ${value.toInt()}',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) => Text(
                spendingByCategory.keys.elementAt(value.toInt()),
                style: const TextStyle(fontSize: 8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Transaction {
  final String description;
  final String date;
  final double amount;
  final TransactionType type;

  Transaction(this.description, this.date, this.amount, this.type);
}

enum TransactionType { income, expense }
