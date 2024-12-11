import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // Estados das notificações
  bool noticias = true;
  bool investimentos = true;
  bool metas = false;
  bool conquistas = false;
  bool outrasAtualizacoes = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notificações",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            const Text(
              "Configurações de Notificações",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Escolha os tipos de notificações que deseja receber.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),

            // Lista de Categorias
            _buildNotificationSwitch(
              title: "Notícias",
              description: "Receba alertas sobre novas notícias financeiras.",
              value: noticias,
              onChanged: (value) {
                setState(() {
                  noticias = value;
                });
              },
            ),
            _buildNotificationSwitch(
              title: "Investimentos",
              description:
                  "Fique atualizado sobre o mercado e seus investimentos fictícios.",
              value: investimentos,
              onChanged: (value) {
                setState(() {
                  investimentos = value;
                });
              },
            ),
            _buildNotificationSwitch(
              title: "Metas",
              description: "Seja avisado quando suas metas forem concluídas.",
              value: metas,
              onChanged: (value) {
                setState(() {
                  metas = value;
                });
              },
            ),
            _buildNotificationSwitch(
              title: "Conquistas",
              description:
                  "Receba notificações sobre conquistas desbloqueadas.",
              value: conquistas,
              onChanged: (value) {
                setState(() {
                  conquistas = value;
                });
              },
            ),
            _buildNotificationSwitch(
              title: "Outras Atualizações",
              description:
                  "Receba alertas sobre novas funcionalidades e eventos do app.",
              value: outrasAtualizacoes,
              onChanged: (value) {
                setState(() {
                  outrasAtualizacoes = value;
                });
              },
            ),

            const SizedBox(height: 24),

            // Botão Salvar
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Simular salvamento das configurações
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Configurações salvas com sucesso!"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  "Salvar Configurações",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Switch de Notificação
  Widget _buildNotificationSwitch({
    required String title,
    required String description,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.orange,
          ),
        ],
      ),
    );
  }
}
