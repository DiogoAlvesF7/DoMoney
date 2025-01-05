// ignore_for_file: unnecessary_const

import 'package:do_money_teste/screens/quizzes/quiz_exemplo.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Quiz> quizzes = [
    Quiz(
      title: "Educação Financeira",
      questions: [
        Question(
          questionText: "O que é educação financeira?",
          options: [
            "Planejar viagens",
            "Gerenciar dinheiro",
            "Comprar ações",
            "Economizar energia"
          ],
          correctOptionIndex: 1,
        ),
        Question(
          questionText: "Qual a regra do método 50/30/20?",
          options: [
            "50% gastos essenciais",
            "30% lazer",
            "20% poupança/investimentos",
            "Todas as alternativas"
          ],
          correctOptionIndex: 3,
        ),
        Question(
          questionText: "O que significa receita?",
          options: ["Gasto", "Dinheiro recebido", "Poupança", "Investimento"],
          correctOptionIndex: 1,
        ),
        Question(
          questionText: "Como juros compostos funcionam?",
          options: [
            "Juros sobre o valor principal",
            "Juros sobre juros acumulados",
            "Juros fixos",
            "Nenhuma das opções"
          ],
          correctOptionIndex: 1,
        ),
        Question(
          questionText: "O que define planejamento financeiro de longo prazo?",
          options: [
            "Objetivos de 1 mês",
            "Objetivos de até 1 ano",
            "Objetivos acima de 5 anos",
            "Nenhuma das alternativas"
          ],
          correctOptionIndex: 2,
        ),
      ],
    ),
    // Outros quizzes podem ser adicionados aqui.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text("Quizzes - Módulo 1",
            style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: Tooltip(
          message: "Voltar",
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.orange),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          return QuizCard(
            title: quizzes[index].title,
            description:
                "Teste seus conhecimentos sobre \n         educação financeira.",
            questionCount: quizzes[index].questions.length,
            difficulty: "Fácil",
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        height: 120,
        color: Colors.grey[900],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 170,
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(10),
                    minHeight: 10,
                    value: 0.2,
                    backgroundColor: Colors.grey[800],
                    valueColor: const AlwaysStoppedAnimation(Colors.orange),
                  ),
                ),
                const Spacer(),
                const Text("1/5",
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                const Text("Concluídos",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    )),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/materialdidatico');
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, elevation: 1),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text('Materiais Didáticos',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 15),
                  Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizDetailPage extends StatelessWidget {
  final Quiz quiz;

  const QuizDetailPage({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(quiz.title,
            style: const TextStyle(
                color: Colors.orange, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: quiz.questions.length,
        itemBuilder: (context, index) {
          final question = quiz.questions[index];
          return QuestionCard(question: question);
        },
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final Question question;

  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.questionText,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...question.options.map((option) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[700],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Adicionar lógica de resposta aqui
                    },
                    child: Text(option),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class Quiz {
  final String title;
  final List<Question> questions;

  Quiz({required this.title, required this.questions});
}

class Question {
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
  });
}

class QuizCard extends StatelessWidget {
  final String title;
  final String description;
  final int questionCount;
  final String difficulty;

  const QuizCard({
    super.key,
    required this.title,
    required this.description,
    required this.questionCount,
    required this.difficulty,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Divider(
              color: Colors.white30,
              thickness: 1,
              height: 1,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.help_outline, color: Colors.amber, size: 20),
                const SizedBox(width: 8),
                Text(
                  "$questionCount questões",
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.speed, color: Colors.amber, size: 20),
                const SizedBox(width: 8),
                Text(
                  "Nível: $difficulty",
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.white30, thickness: 1, height: 1),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuizDetailScreen(
                            title: title,
                            questionCount: questionCount,
                            progress: 0.0,
                            difficulty: difficulty,
                          )),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.orange,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.open_in_new, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Abrir",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizDetailScreen extends StatelessWidget {
  final String title;
  final int questionCount;
  final double progress; // Valor de 0.0 a 1.0
  final String difficulty;

  const QuizDetailScreen({
    Key? key,
    required this.title,
    required this.questionCount,
    required this.progress,
    required this.difficulty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 100,
        leading: Tooltip(
          message: 'Voltar',
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.orange),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(title,
            style: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Informações principais do quiz
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                color: Colors.grey[900],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  "Detalhes do Quiz",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Divider(
                                color: Colors.white30,
                                thickness: 1,
                                height: 1,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const Icon(Icons.help_outline,
                                      color: Colors.amber, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    "$questionCount questões",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.speed,
                                      color: Colors.amber, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Nível: $difficulty",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Text("XP",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.amber,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 8),
                                  Text(
                                    "máximo: ${questionCount * 100}",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(
                            color: Colors.white30,
                            thickness: 1,
                            height: 1,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizCountdownScreen(
                                    onCountdownComplete: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => QuizScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.orange,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.play_arrow_rounded,
                                    color: Colors.white),
                                SizedBox(width: 4),
                                Text(
                                  "Jogar",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Botões de ação
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Adicionar lógica para compartilhar o quiz
                      },
                      icon: const Icon(Icons.share, color: Colors.white),
                      label: const Text("Compartilhar",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.people, color: Colors.white),
                      label: const Text("Desafiar amigos",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.leaderboard, color: Colors.white),
                      label: const Text("Ver ranking",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Configurações
              const Divider(color: Colors.white30, thickness: 1, height: 1),
              const SizedBox(height: 8),
              const Text(
                "Configurações",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SwitchListTile(
                value: false,
                onChanged: (val) {},
                title: const Text("Ler texto em voz alta",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
              SwitchListTile(
                value: true,
                onChanged: (val) {},
                title: const Text("Temporizador",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
              SwitchListTile(
                value: true,
                onChanged: (val) {},
                title: const Text("Modo escuro",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              ),

              const SizedBox(height: 8),
              // Atividade recente
              const Divider(color: Colors.white30, thickness: 1, height: 1),
              const SizedBox(height: 8),
              const Text(
                "Atividade recente",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                color: Colors.grey[900],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Educação Financeira",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "40%",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        value: 0.4,
                        backgroundColor: Colors.grey[800],
                        valueColor: const AlwaysStoppedAnimation(Colors.orange),
                        minHeight: 8,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "10/10/2023 14:30",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class QuizCountdownScreen extends StatefulWidget {
  final VoidCallback onCountdownComplete;

  const QuizCountdownScreen({super.key, required this.onCountdownComplete});

  @override
  _QuizCountdownScreenState createState() => _QuizCountdownScreenState();
}

class _QuizCountdownScreenState extends State<QuizCountdownScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentNumber = 3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (_currentNumber > 1) {
            setState(() {
              _currentNumber--;
            });
            _controller.reset();
            _controller.forward();
          } else {
            widget.onCountdownComplete();
          }
        }
      });
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Text(
            _currentNumber.toString(),
            style: const TextStyle(
              color: Colors.amber,
              fontSize: 100,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
