import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraficoBarras extends StatelessWidget {
  final Map<String, double> segmentos;
  final String? segmentoSelecionado;
  final double total;
  final Function(String segmento)? selecionarSegmento;

  const GraficoBarras({
    super.key,
    required this.segmentos,
    required this.segmentoSelecionado,
    required this.total,
    this.selecionarSegmento,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título com valor total
        Padding(
          padding: const EdgeInsets.all(24.5),
          child: Center(
            child: Column(
              children: [
                const Text(
                  "Total: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "R\$ ${total.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Botão Adicionar Segmento (somente ícone)
                      IconButton(
                        onPressed: () {
                          // Adiciona um novo segmento com valor aleatório
                          const novoSegmento = "Novo Segmento";
                          final valor = segmentos.isEmpty
                              ? 100.0
                              : segmentos.values.reduce((a, b) => a + b) / 2;
                          segmentos[novoSegmento] = valor;
                          selecionarSegmento?.call(novoSegmento);
                        },
                        icon: const Icon(Icons.add_circle,
                            size: 24, color: Colors.green),
                        tooltip: "Adicionar Segmento",
                      ),
                      const SizedBox(width: 1), // Espaço entre os botões

                      // Botão Remover Segmento (somente ícone)
                      IconButton(
                        onPressed: () {
                          if (segmentoSelecionado != null) {
                            segmentos.remove(segmentoSelecionado);
                            selecionarSegmento?.call(
                              segmentos.keys.first,
                            );
                          }
                        },
                        icon: Icon(
                          Icons.remove_circle,
                          size: 24,
                          color: segmentoSelecionado != null
                              ? Colors.red
                              : Colors.grey,
                        ),
                        tooltip: "Remover Segmento",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Gráfico de Barras
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 250,
                child: BarChart(
                  BarChartData(
                    maxY: 100, // Escala do eixo Y em porcentagem
                    barGroups: segmentos.entries
                        .toList()
                        .asMap()
                        .map((index, entry) {
                          final isSelected = segmentoSelecionado == entry.key;
                          final percent = (entry.value / total) * 100;

                          return MapEntry(
                            index,
                            BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: percent,
                                  color: isSelected
                                      ? Colors.red
                                      : Colors.red.withOpacity(0.7),
                                  width: 20, // Espessura da barra
                                  borderRadius:
                                      BorderRadius.circular(0), // Retas
                                ),
                              ],
                            ),
                          );
                        })
                        .values
                        .toList(),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              "${value.toInt()}%",
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 50,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index >= 0 && index < segmentos.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: SizedBox(
                                  width:
                                      100, // Espaçamento fixo para evitar overlap
                                  child: Text(
                                    segmentos.keys.elementAt(index),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: Colors.grey[300],
                        strokeWidth: 1,
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Eixo X rolável
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: segmentos.keys.map((segmento) {
                    final isSelected = segmentoSelecionado == segmento;

                    return GestureDetector(
                      onTap: () => selecionarSegmento?.call(segmento),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 16.0,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected ? Colors.redAccent : Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.redAccent.withOpacity(0.4),
                                    blurRadius: 6,
                                    offset: const Offset(2, 2),
                                  ),
                                ]
                              : [],
                        ),
                        child: Text(
                          segmento,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
