import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Para gráficos

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Perfil',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            color: Colors.white,
            onPressed: () {
              // Navegar para configurações
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileSection(context),
              const SizedBox(height: 20),
              _buildStatisticsSection(context),
              const SizedBox(height: 20),
              _buildProgressSection(),
              const SizedBox(height: 20),
              _buildAchievementsSection(),
              const SizedBox(height: 20),
              _buildFriendsSection(context),
              const SizedBox(height: 20),
              _buildGoalsSection(),
              const SizedBox(height: 20),
              _buildRewardsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage('https://i.imgur.com/Qr71crq.png'),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome do Usuário',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'usuario@domoney.com',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Ação para adicionar amigos
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: const Text('Adicionar Amigos'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatisticsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Estatísticas',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        _buildStatsCard('Tempo Jogando', '15h 30m'),
        _buildStatsCard('Dias de Ofensiva', '7 dias'),
        _buildStatsCard('XP', '2000 XP'),
        _buildStatsCard('Módulos Feitos', '12 módulos'),
        _buildStatsCard('Questões Respondidas', '150 questões'),
        _buildStatsCard('Troféus', '3 troféus'),
        _buildStatsCard('Nível', 'Pro'),
      ],
    );
  }

  Widget _buildProgressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Progresso',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: true),
              borderData: FlBorderData(show: true),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    const FlSpot(0, 5),
                    const FlSpot(1, 10),
                    const FlSpot(2, 15),
                    const FlSpot(3, 20),
                  ],
                  isCurved: true,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.blue.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        _buildProgressLegend(),
      ],
    );
  }

  Widget _buildProgressLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLegendItem(Colors.blue, 'Progresso Geral'),
        _buildLegendItem(Colors.green, 'Objetivos Diários'),
        _buildLegendItem(Colors.orange, 'Módulos Concluídos'),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }

  Widget _buildAchievementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Conquistas',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildAchievementCard('Conquista 1', 'Descrição da conquista 1'),
        _buildAchievementCard('Conquista 2', 'Descrição da conquista 2'),
        _buildAchievementCard('Conquista 3', 'Descrição da conquista 3'),
        _buildAchievementCard('Conquista 4', 'Descrição da conquista 4'),
      ],
    );
  }

  Widget _buildFriendsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Amigos',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                  'https://media.istockphoto.com/id/1495088043/vector/user-profile-icon-avatar-or-person-icon-profile-picture-portrait-symbol-default-portrait.jpg?s=612x612&w=0&k=20&c=dhV2p1JwmloBTOaGAtaA3AW1KSnjsdMt7-U_3EZElZ0='),
            ),
            const SizedBox(width: 8),
            const CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                  'https://media.istockphoto.com/id/1495088043/vector/user-profile-icon-avatar-or-person-icon-profile-picture-portrait-symbol-default-portrait.jpg?s=612x612&w=0&k=20&c=dhV2p1JwmloBTOaGAtaA3AW1KSnjsdMt7-U_3EZElZ0='),
            ),
            const SizedBox(width: 8),
            const CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                  'https://media.istockphoto.com/id/1495088043/vector/user-profile-icon-avatar-or-person-icon-profile-picture-portrait-symbol-default-portrait.jpg?s=612x612&w=0&k=20&c=dhV2p1JwmloBTOaGAtaA3AW1KSnjsdMt7-U_3EZElZ0='),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                // Ação para ver mais amigos
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: const Text('Ver Todos'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGoalsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Metas',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildGoalCard('Meta 1', 'Complete 5 módulos por semana'),
        _buildGoalCard('Meta 2', 'Responda 50 questões diariamente'),
        _buildGoalCard('Meta 3', 'Ganhe 500 XP por mês'),
      ],
    );
  }

  Widget _buildRewardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recompensas',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildRewardCard('Recompensa 1', 'Desbloqueie um novo avatar'),
        _buildRewardCard('Recompensa 2', 'Acesso a conteúdo exclusivo'),
        _buildRewardCard('Recompensa 3', 'Ganhe medalhas de honra'),
      ],
    );
  }

  Widget _buildStatsCard(String title, String value) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildAchievementCard(String title, String description) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: const Icon(Icons.star, color: Colors.amber),
        title: Text(title),
        subtitle: Text(description),
      ),
    );
  }

  Widget _buildGoalCard(String title, String description) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: const Icon(Icons.flag, color: Colors.blue),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.check, color: Colors.green),
      ),
    );
  }

  Widget _buildRewardCard(String title, String description) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: const Icon(Icons.card_giftcard, color: Colors.red),
        title: Text(title),
        subtitle: Text(description),
      ),
    );
  }
}
