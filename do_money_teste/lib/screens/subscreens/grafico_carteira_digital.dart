import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraficoCarteiraDigital extends StatefulWidget {
  const GraficoCarteiraDigital({super.key});

  @override
  State<GraficoCarteiraDigital> createState() => _GraficoCarteiraDigitalState();
}

class _GraficoCarteiraDigitalState extends State<GraficoCarteiraDigital> {
  final List<Map<String, dynamic>> segmentos = [
    {"nome": "Ações", "valor": 9149.99, "cor": Colors.blueAccent},
    {"nome": "CDB", "valor": 8970.99, "cor": Colors.greenAccent},
    {"nome": "COE", "valor": 8990.99, "cor": Colors.orangeAccent},
    {"nome": "Debêntures", "valor": 7900.99, "cor": Colors.purpleAccent},
  ];

  String? segmentoSelecionado;
  double? valorSegmentoSelecionado;

  double get valorTotal =>
      segmentos.fold(0.0, (soma, segmento) => soma + segmento["valor"]);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Título acima do gráfico
        const Text(
          "Distribuição da Carteira",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),

        // Gráfico Circular
        SizedBox(
          height: 250,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 4,
                  centerSpaceRadius: 80, // Espaço central mais clean
                  sections: _buildSections(),
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      if (event is FlTapUpEvent) {
                        final touchedSection = pieTouchResponse?.touchedSection;
                        if (touchedSection != null) {
                          final touchedIndex =
                              touchedSection.touchedSectionIndex;

                          // Verifica se o índice está no intervalo válido
                          if (touchedIndex >= 0 &&
                              touchedIndex < segmentos.length) {
                            setState(() {
                              if (segmentos[touchedIndex]["nome"] ==
                                  segmentoSelecionado) {
                                segmentoSelecionado = null;
                                valorSegmentoSelecionado = null;
                              } else {
                                segmentoSelecionado =
                                    segmentos[touchedIndex]["nome"];
                                valorSegmentoSelecionado =
                                    segmentos[touchedIndex]["valor"];
                              }
                            });
                          }
                        } else {
                          // Clique fora dos segmentos ou no centro do gráfico
                          setState(() {
                            segmentoSelecionado = null;
                            valorSegmentoSelecionado = null;
                          });
                        }
                      }
                    },
                  ),
                ),
              ),

              // Valor no centro do gráfico
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    segmentoSelecionado ?? "Clique no gráfico",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                  if (segmentoSelecionado != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      "R\$ ${valorSegmentoSelecionado!.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "${((valorSegmentoSelecionado! / valorTotal) * 100).toStringAsFixed(1)}% do total",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Legenda
        _buildLegenda(),
      ],
    );
  }

  // Seções do gráfico
  List<PieChartSectionData> _buildSections() {
    return segmentos.map((segmento) {
      final isSelected = segmento["nome"] == segmentoSelecionado;
      return PieChartSectionData(
        color: segmento["cor"],
        value: segmento["valor"],
        title: isSelected
            ? "${((segmento["valor"] / valorTotal) * 100).toStringAsFixed(1)}%"
            : "",
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        radius: isSelected ? 50 : 40,
      );
    }).toList();
  }

  // Legenda abaixo do gráfico
  Widget _buildLegenda() {
    return Column(
      children: segmentos.map((segmento) {
        final isSelected = segmento["nome"] == segmentoSelecionado;
        return ListTile(
          tileColor: isSelected ? Colors.white30 : Colors.transparent,
          leading: CircleAvatar(
            backgroundColor: segmento["cor"],
            radius: 8,
          ),
          title: Text(
            segmento["nome"],
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.orange : Colors.white,
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "R\$ ${segmento["valor"].toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${((segmento["valor"] / valorTotal) * 100).toStringAsFixed(1)}% da carteira",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            setState(() {
              if (segmento["nome"] == segmentoSelecionado) {
                segmentoSelecionado = null;
                valorSegmentoSelecionado = null;
              } else {
                segmentoSelecionado = segmento["nome"];
                valorSegmentoSelecionado = segmento["valor"];
              }
            });
          },
        );
      }).toList(),
    );
  }
}
