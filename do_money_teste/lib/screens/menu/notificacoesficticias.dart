import 'package:flutter/material.dart';

class NotificacoesPage extends StatelessWidget {
  const NotificacoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Tooltip(
          message: 'Voltar',
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.black,
        title: const Text(
          "Notificações",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          // Título de notificações
          Row(
            children: [
              const Text(
                "Notificações não lidas",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  '1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),

          // Notificações
          _buildNotificationCard(
            title: "Parabéns! 🎉",
            description:
                "Você completou a meta semanal de economia. Confira seus ganhos no progresso.",
            time: "Há 2 horas",
          ),
          const Divider(color: Colors.white24, thickness: 1, height: 1),
          const SizedBox(height: 16),
          const Text("Todas",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 16),
          _buildNotificationCard(
            title: "Desafio disponível",
            description:
                "Participe do novo desafio 'Investidor do Mês' e conquiste recompensas exclusivas.",
            time: "Há 5 horas",
          ),
          _buildNotificationCard(
            title: "Novidades no DoMoney",
            description:
                "Adicionamos novos módulos sobre planejamento financeiro. Explore agora!",
            time: "Ontem",
          ),

          // Título de solicitações de amizade
          const SizedBox(height: 24),
          const Text(
            "Solicitações de amizade",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Solicitações de amizade
          _buildFriendRequestCard(
            avatarUrl:
                'assets/images/Imagem do WhatsApp de 2025-01-02 à(s) 20.17.36_48487f89.jpg',
            username: "joao_silva",
            mutualFriends: 5,
            onAccept: () {
              // Ação ao aceitar a solicitação
            },
            onDecline: () {
              // Ação ao recusar a solicitação
            },
          ),
          _buildFriendRequestCard(
            avatarUrl:
                'assets/images/Imagem do WhatsApp de 2025-01-02 à(s) 20.19.45_3d5d3d2f.jpg',
            username: "maria_oliveira",
            mutualFriends: 2,
            onAccept: () {
              // Ação ao aceitar a solicitação
            },
            onDecline: () {
              // Ação ao recusar a solicitação
            },
          ),
          _buildFriendRequestCard(
            avatarUrl:
                'assets/images/Imagem do WhatsApp de 2025-01-02 à(s) 20.22.33_2a7174ee.jpg',
            username: "carlos_souza",
            mutualFriends: 3,
            onAccept: () {
              // Ação ao aceitar a solicitação
            },
            onDecline: () {
              // Ação ao recusar a solicitação
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String description,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            time,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendRequestCard({
    required String username,
    required int mutualFriends,
    required VoidCallback onAccept,
    required VoidCallback onDecline,
    required String avatarUrl,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Informações do usuário
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(avatarUrl),
                      radius: 20,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.group, color: Colors.white54, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      "$mutualFriends amigos em comum",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Botões de ação
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.check, color: Colors.green),
                onPressed: onAccept,
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: onDecline,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
