import 'package:flutter/material.dart';
import 'resumo_balanco.dart'; // Arquivo com o widget ResumoBalanco

class BalancoFinanceiro extends StatelessWidget {
  const BalancoFinanceiro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resumo Financeiro',
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
            ResumoBalanco(
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

            // Espaço reservado para Gráficos
            const Placeholder(
              fallbackHeight: 300,
              color: Colors.orange,
              strokeWidth: 2,
            ),
            const SizedBox(height: 16),

            // Espaço reservado para Ações de Personalização
            const Placeholder(
              fallbackHeight: 200,
              color: Colors.blue,
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
