import 'package:flutter/material.dart';
import 'graficos_despesas.dart';
import 'resumo_balanco.dart';
import 'grafico_barras.dart';

class BalancoFinanceiro extends StatefulWidget {
  const BalancoFinanceiro({super.key});

  @override
  _BalancoFinanceiroState createState() => _BalancoFinanceiroState();
}

class _BalancoFinanceiroState extends State<BalancoFinanceiro> {
  bool exibirGraficoBarras = false; // Controle para alternar entre gráficos
  final Map<String, double> segmentos = {
    "Alimentação": 80.0,
    "Transporte": 50.0,
    "Saúde": 100.0,
    "Educação": 40.0,
    "Lazer": 30.0,
  };

  String? _segmentoSelecionado;

  // Selecionar ou desselecionar segmento
  void _selecionarSegmento(String segmento) {
    setState(() {
      if (_segmentoSelecionado == segmento) {
        _segmentoSelecionado = null;
      } else {
        _segmentoSelecionado = segmento;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final total = segmentos.values.reduce((a, b) => a + b);

    return Scaffold(
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ResumoBalanco(
              receitaMedia: 3200.75,
              transacoesRecentes: [
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
              ],
            ),
            const SizedBox(height: 24),

            // Título centralizado
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Título principal
                  Text(
                    "Despesas",
                    style: TextStyle(
                      fontSize: 28, // Um pouco menor para um equilíbrio
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 6),
                  // Subtítulo minimalista
                  Text(
                    "Acompanhe seus gastos em gráficos",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            // Alternância entre gráficos
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      exibirGraficoBarras = false;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: !exibirGraficoBarras
                          ? Colors.redAccent
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: !exibirGraficoBarras
                          ? [
                              BoxShadow(
                                color: Colors.redAccent.withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(2, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.pie_chart,
                          color: !exibirGraficoBarras
                              ? Colors.white
                              : Colors.black,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Setores",
                          style: TextStyle(
                            color: !exibirGraficoBarras
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      exibirGraficoBarras = true;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: exibirGraficoBarras
                          ? Colors.redAccent
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: exibirGraficoBarras
                          ? [
                              BoxShadow(
                                color: Colors.redAccent.withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(2, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.bar_chart,
                          color:
                              exibirGraficoBarras ? Colors.white : Colors.black,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Barras",
                          style: TextStyle(
                            color: exibirGraficoBarras
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Gráfico selecionado
            SizedBox(
              height: 500,
              child: exibirGraficoBarras
                  ? GraficoBarras(
                      segmentos: segmentos,
                      segmentoSelecionado: _segmentoSelecionado,
                      selecionarSegmento: _selecionarSegmento,
                      total: total,
                    )
                  : GraficoDespesas(),
            ),
          ],
        ),
      ),
    );
  }
}
