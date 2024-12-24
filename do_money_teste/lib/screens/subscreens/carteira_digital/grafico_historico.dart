import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HistoricoProgresso extends StatelessWidget {
  final List<FlSpot> pontosHistorico;
  final double maxValue;
  final double minValue;

  const HistoricoProgresso({
    super.key,
    required this.pontosHistorico,
    required this.maxValue,
    required this.minValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Título
          const Text(
            "Histórico da Carteira",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Divider(color: Colors.white24),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    "Mínimo",
                    style: TextStyle(
                      fontSize: 13, // Fonte menor
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "R\$ ${minValue.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 13, // Fonte menor
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              VerticalDivider(color: Colors.white70),
              Column(
                children: [
                  const Text(
                    "Máximo",
                    style: TextStyle(
                      fontSize: 13, // Fonte menor
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "R\$ ${maxValue.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 13, // Fonte menor
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Gráfico
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: SizedBox(
              height: 180,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final int index = value.toInt();
                          if (index < 0 || index >= pontosHistorico.length) {
                            return Container();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Dia ${index + 1}",
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 10, // Fonte reduzida
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  minX: 0,
                  maxX: pontosHistorico.length.toDouble() - 1,
                  minY: minValue - 500,
                  maxY: maxValue + 500,
                  lineBarsData: [
                    LineChartBarData(
                      spots: pontosHistorico,
                      isCurved: false,
                      color: Colors.orange,
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.orange.withOpacity(0.3),
                      ),
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 3,
                            color: Colors.orange,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildResumoHistorico(
      IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
