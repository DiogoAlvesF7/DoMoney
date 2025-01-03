import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final List<Map<String, dynamic>> _goals = [
    {
      "title": "Pagar Dívidas",
      "description": "Quitar todas as dívidas pendentes até o final do ano.",
      "deadline": DateTime(2024, 12, 31),
      "isCompleted": true,
      "isSelected": true,
    },
    {
      "title": "Investir R\$ 1000",
      "description": "Investir R\$ 1000 em ações em Janeiro.",
      "deadline": DateTime(2025, 1, 31),
      "isCompleted": true,
      "isSelected": true,
    },
    {
      "title": "Reduzir Gastos",
      "description": "Reduzir os gastos mensais em 15% nos próximos 3 meses.",
      "deadline": DateTime(2025, 3, 31),
      "isCompleted": false,
      "isSelected": true,
    },
    {
      "title": "Criar Fundo de Emergência",
      "description":
          "Criar um fundo de emergência com R\$ 5000 até o final do próximo ano.",
      "deadline": DateTime(2025, 12, 31),
      "isCompleted": false,
      "isSelected": true,
    },
    {
      "title": "Aprender Flutter",
      "description": "Completar um curso de Flutter até o final do ano.",
      "deadline": DateTime(2024, 12, 31),
      "isCompleted": false,
      "isSelected": true,
      "deadlinePassed": true,
    },
    {
      "title": "Ler 5 livros",
      "description": "Ler 5 livros em Dezembro.",
      "deadline": DateTime(2024, 12, 31),
      "isCompleted": false,
      "isSelected": true,
      "deadlinePassed": true,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text(
          "Perfil",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          Tooltip(
            message: 'Editar perfil',
            child: IconButton(
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                // Navegar para editar perfil
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditProfilePage()),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Identidade do Usuário
            _buildProfileHeader(),
            const SizedBox(height: 12),

            const Divider(color: Colors.white10, thickness: 1, height: 1),
            const SizedBox(height: 24),
            const UserStatisticsWidget(
              totalXP: 22487,
              totalBalance: 30509.04,
              totalInvested: 27509.00,
              totalEarnings: 42305.05,
              totalAchievements: 7,
              materialsStudied: 3,
              overallPerformance: 92.0,
            ),
            const SizedBox(height: 24),
            const Divider(color: Colors.white10, thickness: 1, height: 1),
            const SizedBox(height: 24),
            // Amigos
            Row(
              children: [
                const Text(
                  "Amigos",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                const Text("5",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                const SizedBox(width: 8),
                Icon(Icons.group, color: Colors.grey[600]),
              ],
            ),
            const SizedBox(height: 16),
            _buildFriends(),

            // Conquistas
            const SizedBox(height: 24),
            const Divider(color: Colors.white10, thickness: 1, height: 1),
            const SizedBox(height: 24),
            const UserStreakWidget(),
            const SizedBox(height: 24),
            const Divider(color: Colors.white10, thickness: 1, height: 1),
            const SizedBox(height: 24),
            const Row(
              children: [
                Text(
                  "Conquistas",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                Text("7/25",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(width: 8),
                Icon(Icons.emoji_events, color: Colors.orange),
              ],
            ),
            const SizedBox(height: 16),
            _buildAchievements(),

            // Metas Ativas
            const SizedBox(height: 24),
            const Divider(color: Colors.white10, thickness: 1, height: 1),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Minhas metas",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 18),
                Tooltip(
                  message: 'Adicionar nova meta',
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      // Navegar para adicionar meta
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            _buildActiveGoals(),
            ElevatedButton.icon(
              onPressed: () {
                // Ação ao clicar no botão
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[850],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize:
                    const Size.fromHeight(50), // Ocupa a largura máxima
              ),
              icon: const Icon(Icons.list_alt_outlined, color: Colors.white),
              label: const Text(
                "Ver todas",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Identidade do Usuário
  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          const Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                backgroundColor: Colors.black,
                radius: 50,
                backgroundImage: AssetImage(
                    "assets/images/Captura de tela 2024-12-18 093558.png"),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "@diogo_ferreira",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Diogo Ferreira",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sócio Sênior", // Cargo atual
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.verified,
                  color: Colors.blue, size: 16), // Ícone de verificado
            ],
          ),
          const SizedBox(height: 6),
          // Barra de progresso de XP
          LinearProgressIndicator(
            value: 0.75, // Progresso atual (aqui vem o valor do XP)
            color: Colors.orange,
            backgroundColor: Colors.grey[800],
            minHeight: 8,
          ),
          const SizedBox(height: 8),
          const Text(
            "22487 / 30000 XP para CEO", // Texto explicativo sobre o próximo cargo
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              "Membro desde 2023", // Data de entrada na plataforma
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Conquistas
  Widget _buildAchievements() {
    final List<Map<String, dynamic>> achievements = [
      {
        "title": "Primeira Meta",
        "description": "Concluiu a primeira meta.",
        "icon": Icons.star,
      },
      {
        "title": "Investidor",
        "description": "Investiu R\$ 1000 em ações.",
        "icon": Icons.trending_up,
      },
      {
        "title": "Leitor",
        "description": "Leu 5 materiais didáticos em um dia.",
        "icon": Icons.book,
      },
      {
        "title": "Economista",
        "description": "Reduziu os gastos mensais em 15%.",
        "icon": Icons.attach_money,
      },
      {
        "title": "Aprendiz",
        "description": "Usou o simulador pela primeira vez.",
        "icon": Icons.school,
      },
      {
        "title": "Amigo",
        "description": "Fez 5 amigos na plataforma.",
        "icon": Icons.people,
      },
      {
        "title": "Poupador",
        "description": "Criou um fundo de emergência.",
        "icon": Icons.savings,
      },
    ];

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: achievements.length + 1,
        itemBuilder: (context, index) {
          if (index == achievements.length) {
            return Container(
              margin: const EdgeInsets.only(right: 16),
              width: 120,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Icon(Icons.add, color: Colors.white, size: 58),
                  ),
                  SizedBox(height: 11),
                  Text(
                    "Ver todas",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            );
          }

          final achievement = achievements[index];
          return Container(
            margin: const EdgeInsets.only(right: 16),
            width: 120,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(achievement['icon'], color: Colors.orange, size: 36),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 1.0, right: 1.0),
                  child: Text(
                    achievement['title'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 6),
                const Padding(
                  padding: EdgeInsets.only(left: 6.0, right: 6.0),
                  child:
                      Divider(color: Colors.white10, thickness: 1, height: 1),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 1.5, right: 1.5, bottom: 0.5),
                  child: Text(
                    achievement['description'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10, color: Colors.white70),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Metas Ativas
  Widget _buildActiveGoals() {
    return Column(
      children: _goals.map((goal) {
        // Determina as cores e o ícone com base no estado da meta
        Color borderColor;
        Color iconBackgroundColor;
        IconData icon;

        if (!goal['isSelected']) {
          borderColor = Colors.grey[700]!;
          iconBackgroundColor = Colors.transparent;
          icon = Icons.remove;
        } else if (goal['isCompleted']) {
          borderColor = Colors.green;
          iconBackgroundColor = Colors.green;
          icon = Icons.check;
        } else if (!goal['isCompleted'] &&
            goal.containsKey('deadlinePassed') &&
            goal['deadlinePassed']) {
          borderColor = Colors.red;
          iconBackgroundColor = Colors.red;
          icon = Icons.close;
        } else {
          borderColor = Colors.orange;
          iconBackgroundColor = Colors.orange;
          icon = Icons.hourglass_bottom;
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: goal['isSelected'] ? Colors.grey[900] : Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Conteúdo principal da meta
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    goal['title'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    goal['description'],
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        "Prazo: ${goal['deadline'].day.toString().padLeft(2, '0')}/${goal['deadline'].month.toString().padLeft(2, '0')}/${goal['deadline'].year}", // Exibe a data formatada
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white54,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (!goal['isCompleted'] &&
                              !(goal.containsKey('deadlinePassed') &&
                                  goal['deadlinePassed']))
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.white),
                              onPressed: () {
                                // Lógica para editar a meta
                              },
                              tooltip: 'Editar',
                            ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white),
                            onPressed: () {
                              // Lógica para remover a meta
                            },
                            tooltip: 'Remover',
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // Ícone indicando o estado da meta
              if (goal['isSelected'])
                Positioned(
                  top: 0,
                  right: 8,
                  child: Tooltip(
                    message: goal['isCompleted']
                        ? 'Concluído'
                        : goal.containsKey('deadlinePassed') &&
                                goal['deadlinePassed']
                            ? 'Não concluído'
                            : 'Em andamento',
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: iconBackgroundColor,
                      child: Icon(icon, size: 16, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // Amigos
  final List<Map<String, dynamic>> _friends = [
    {
      "username": "joao_silva",
      "profileImage":
          "assets/images/Imagem do WhatsApp de 2025-01-02 à(s) 20.17.36_48487f89.jpg",
      "isOnline": true,
    },
    {
      "username": "maria_oliveira",
      "profileImage":
          "assets/images/Imagem do WhatsApp de 2025-01-02 à(s) 20.19.45_3d5d3d2f.jpg",
      "isOnline": true,
    },
    {
      "username": "carlos_souza",
      "profileImage":
          "assets/images/Imagem do WhatsApp de 2025-01-02 à(s) 20.22.33_2a7174ee.jpg",
      "isOnline": true,
    },
    {
      "username": "ana_pereira",
      "profileImage":
          "assets/images/Imagem do WhatsApp de 2025-01-02 à(s) 20.23.19_d80e9225.jpg",
      "isOnline": true,
    },
    {
      "username": "lucas_lima",
      "profileImage":
          "assets/images/Imagem do WhatsApp de 2025-01-02 à(s) 20.23.55_cfe55ff5.jpg",
      "isOnline": false,
    },
  ];

  Widget _buildFriends() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _friends.map((friend) {
          return Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 20, 20, 20),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 30,
                      backgroundImage: AssetImage(friend['profileImage']),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Tooltip(
                        message: friend['isOnline'] ? 'Online' : 'Offline',
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor:
                              friend['isOnline'] ? Colors.green : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  friend['username'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        }).toList()
          ..add(
            Container(
              height: 103,
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Icon(Icons.add, color: Colors.white, size: 48),
                  ),
                  SizedBox(height: 11),
                  Text(
                    "Encontrar mais \npessoas",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}

class UserStreakWidget extends StatelessWidget {
  final int loggedDays; // Número de dias logados
  const UserStreakWidget({super.key, this.loggedDays = 3});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título e ícone
        Row(
          children: [
            const Text(
              "Ofensiva",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.local_fire_department,
              color: Colors.orange[600],
              size: 24,
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Dias logados
        Text(
          "$loggedDays dias seguidos",
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),

        // Dias de ofensiva
        _buildStreakDays(),

        const SizedBox(height: 24),

        // Recompensas
        const Text(
          "Recompensas",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildRewardCard(
          title: "Bônus de XP 🧠",
          description: "Receba +50 XP após 3 dias de ofensiva.",
          isClaimed: loggedDays >= 3,
        ),
        _buildRewardCard(
          title: "Pequeno bônus 💰",
          description: "Ganhe \$50 ao completar 7 dias de ofensiva.",
          isClaimed: loggedDays >= 7,
        ),
        _buildRewardCard(
          title: "Nova conquista 🏆",
          description: "Desbloqueie uma conquista ao completar 14 dias.",
          isClaimed: loggedDays >= 14,
        ),
      ],
    );
  }

  Widget _buildStreakDays() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (index) {
        bool isCompleted = index < loggedDays; // Dias logados
        return Column(
          children: [
            Text(
              ["D", "S", "T", "Q", "Q", "S", "S"][index],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            CircleAvatar(
              radius: 18,
              backgroundColor:
                  isCompleted ? Colors.orange[600] : Colors.grey[700],
              child: isCompleted
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
          ],
        );
      }),
    );
  }

  Widget _buildRewardCard({
    required String title,
    required String description,
    required bool isClaimed,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isClaimed ? Colors.green[600] : Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isClaimed ? Colors.green : Colors.grey[700]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isClaimed ? Icons.check_circle : Icons.lock,
            color: isClaimed ? Colors.white : Colors.grey[500],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserStatisticsWidget extends StatelessWidget {
  final double totalBalance; // Saldo total
  final int totalXP; // XP acumulado
  final double totalInvested; // Valor investido
  final double totalEarnings; // Rendimentos totais
  final int totalAchievements; // Conquistas desbloqueadas
  final int materialsStudied; // Materiais estudados
  final int streakDays; // Dias em ofensiva
  final double overallPerformance; // Aproveitamento geral (%)

  const UserStatisticsWidget({
    super.key,
    this.totalBalance = 1500.0,
    this.totalXP = 3200,
    this.totalInvested = 500.0,
    this.totalEarnings = 80.0,
    this.totalAchievements = 12,
    this.materialsStudied = 24,
    this.streakDays = 15,
    this.overallPerformance = 88.5,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Estatísticas do Usuário",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildStatRow(
          icon: Icons.stars,
          title: "XP Acumulado",
          value: "$totalXP XP",
        ),
        _buildStatRow(
          icon: Icons.account_balance_wallet,
          title: "Saldo Total",
          value: "R\$ ${totalBalance.toStringAsFixed(2)}",
        ),
        _buildStatRow(
          icon: Icons.attach_money,
          title: "Valor Investido",
          value: "R\$ ${totalInvested.toStringAsFixed(2)}",
        ),
        _buildStatRow(
          icon: Icons.trending_up,
          title: "Rendimentos Totais",
          value: "R\$ ${totalEarnings.toStringAsFixed(2)}",
        ),
        _buildStatRow(
          icon: Icons.menu_book,
          title: "Módulos concluídos",
          value: "$materialsStudied",
        ),
        _buildStatRow(
          icon: Icons.percent,
          title: "Aproveitamento Geral",
          value: "${overallPerformance.toStringAsFixed(1)}%",
        ),
      ],
    );
  }

  Widget _buildStatRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.orange,
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializar os controladores com os valores atuais do perfil
    _usernameController.text = "@diogo_ferreira";
    _nameController.text = "Diogo Ferreira";
    _bioController.text = "Sócio Sênior";
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

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
        title: const Text(
          "Editar Perfil",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey[750],
              child: Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                          "assets/images/Captura de tela 2024-12-18 093558.png"),
                    ),
                    Tooltip(
                      message: "Alterar foto",
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        onPressed: () {
                          // Navegar para trocar foto
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: "Nome de usuário",
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Nome",
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bioController,
              decoration: const InputDecoration(
                labelText: "Cargo",
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 24),
            const Text(
              "Configurações de Conta",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.white),
              title: const Text("Alterar Senha",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                // Lógica para alterar a senha
              },
            ),
            const Divider(
              color: Colors.white10,
              thickness: 1,
              height: 1,
            ),
            ListTile(
              leading: const Icon(Icons.mail, color: Colors.white),
              title: const Text("Alterar e-mail",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                // Lógica para configurar notificações
              },
            ),
            const Divider(
              color: Colors.white10,
              thickness: 1,
              height: 1,
            ),
            ListTile(
              leading: const Icon(Icons.delete_forever, color: Colors.white),
              title: const Text("Excluir conta",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                // Lógica para sair da conta
              },
            ),
          ],
        ),
      ),
    );
  }
}
