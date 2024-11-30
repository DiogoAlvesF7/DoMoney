import 'package:do_money_teste/screens/subscreens/graficos_despesas.dart';
import 'package:flutter/material.dart';
import 'resumo_balanco.dart'; // Arquivo com o widget ResumoBalanco

class BalancoFinanceiro extends StatelessWidget {
  const BalancoFinanceiro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Balanço Financeiro',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resumo do Balanço
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

            const SizedBox(height: 32),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Despesas',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            // Espaço reservado para Gráficos
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        GraficoDespesas();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.blue
                              .shade100, // Fundo claro para indicar seleção
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.shade300.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(2, 4),
                            ),
                          ],
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.pie_chart, color: Colors.blue, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Setores',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // Espaçamento entre botões
                    GestureDetector(
                      onTap: () {},
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.orange
                              .shade100, // Fundo claro para indicar seleção
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.shade300.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(2, 4),
                            ),
                          ],
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.bar_chart,
                                color: Colors.orange, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Barras',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            // Integrando o widget do gráfico aqui
            SizedBox(
              height: 400, // Altura ajustável
              child: GraficoDespesas(),
            ),
            // Espaço reservado para Ações de Personalização
          ],
        ),
      ),
    );
  }
}
