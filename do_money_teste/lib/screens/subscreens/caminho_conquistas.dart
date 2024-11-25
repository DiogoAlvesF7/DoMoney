import 'package:flutter/material.dart';

class DoMoneyHub extends StatelessWidget {
  const DoMoneyHub({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prédio DoMoney Simulation'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Acessar configurações
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progresso Geral
            const Text(
              'Progresso Geral',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 20,
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 0.4, // 40% de progresso
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const Text(
                  '40%',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Módulos Disponíveis
            const Text(
              'Módulos Disponíveis',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                children: List.generate(5, (index) {
                  bool isLocked = index > 2; // Bloquear módulos após o terceiro
                  return GestureDetector(
                    onTap: () {
                      if (!isLocked) {
                        // Abrir módulo
                      }
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      color: isLocked ? Colors.grey[300] : Colors.orange[200],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(
                              isLocked ? Icons.lock : Icons.check_circle,
                              size: 40,
                              color: isLocked ? Colors.grey : Colors.green,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Módulo ${index + 1}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          isLocked ? Colors.grey : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    isLocked
                                        ? 'Bloqueado'
                                        : 'Progresso: ${index * 20}%',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isLocked
                                          ? Colors.grey
                                          : Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (!isLocked)
                              const Icon(Icons.arrow_forward_ios,
                                  color: Colors.black54),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context); // Voltar para a home
                },
              ),
              IconButton(
                icon: const Icon(Icons.insights, color: Colors.white),
                onPressed: () {
                  // Navegar para estatísticas gerais
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
