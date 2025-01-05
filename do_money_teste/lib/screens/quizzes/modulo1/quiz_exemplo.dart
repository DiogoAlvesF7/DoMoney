import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'O que é uma poupança?',
      'options': [
        'Uma conta para guardar dinheiro',
        'Um tipo de investimento em ações',
        'Um empréstimo bancário',
        'Uma forma de pagamento'
      ],
      'correctAnswer': 'Uma conta para guardar dinheiro',
    },
    {
      'question': 'Qual é a principal vantagem de uma conta poupança?',
      'options': [
        'Alta rentabilidade',
        'Baixo risco',
        'Alta liquidez',
        'Isenção de impostos'
      ],
      'correctAnswer': 'Baixo risco',
    },
    {
      'question': 'O que é um orçamento pessoal?',
      'options': [
        'Um plano de gastos e receitas',
        'Um tipo de investimento',
        'Um empréstimo',
        'Uma conta bancária'
      ],
      'correctAnswer': 'Um plano de gastos e receitas',
    },
    {
      'question': 'O que significa diversificar investimentos?',
      'options': [
        'Investir em diferentes tipos de ativos',
        'Investir todo o dinheiro em um único ativo',
        'Guardar dinheiro em casa',
        'Pagar todas as dívidas'
      ],
      'correctAnswer': 'Investir em diferentes tipos de ativos',
    },
    {
      'question': 'O que é um fundo de emergência?',
      'options': [
        'Dinheiro reservado para despesas inesperadas',
        'Um tipo de investimento de alto risco',
        'Um empréstimo de curto prazo',
        'Uma conta de poupança'
      ],
      'correctAnswer': 'Dinheiro reservado para despesas inesperadas',
    },
    {
      'question':
          'Qual é a principal característica de um investimento de alto risco?',
      'options': [
        'Alta possibilidade de perda',
        'Baixa rentabilidade',
        'Alta liquidez',
        'Isenção de impostos'
      ],
      'correctAnswer': 'Alta possibilidade de perda',
    },
    {
      'question': 'O que é um CDB (Certificado de Depósito Bancário)?',
      'options': [
        'Um título de dívida emitido por bancos',
        'Um tipo de ação',
        'Um fundo de investimento',
        'Uma conta corrente'
      ],
      'correctAnswer': 'Um título de dívida emitido por bancos',
    },
    {
      'question': 'O que é a taxa Selic?',
      'options': [
        'A taxa básica de juros da economia',
        'A taxa de câmbio',
        'A taxa de inflação',
        'A taxa de desemprego'
      ],
      'correctAnswer': 'A taxa básica de juros da economia',
    },
    {
      'question': 'O que é um IPO (Oferta Pública Inicial)?',
      'options': [
        'A primeira venda de ações de uma empresa ao público',
        'Um tipo de investimento em renda fixa',
        'Um empréstimo bancário',
        'Uma conta de poupança'
      ],
      'correctAnswer': 'A primeira venda de ações de uma empresa ao público',
    },
    {
      'question': 'Qual é a principal diferença entre ações e títulos?',
      'options': [
        'Ações representam propriedade, títulos representam dívida',
        'Ações têm prazo fixo, títulos não',
        'Ações pagam juros, títulos pagam dividendos',
        'Ações são de baixo risco, títulos são de alto risco'
      ],
      'correctAnswer':
          'Ações representam propriedade, títulos representam dívida',
    },
    {
      'question': 'O que é alavancagem financeira?',
      'options': [
        'Usar recursos de terceiros para aumentar o potencial de retorno',
        'Investir apenas com recursos próprios',
        'Guardar dinheiro em uma conta poupança',
        'Pagar todas as dívidas'
      ],
      'correctAnswer':
          'Usar recursos de terceiros para aumentar o potencial de retorno',
    },
    {
      'question': 'O que é um derivativo financeiro?',
      'options': [
        'Um contrato cujo valor deriva de um ativo subjacente',
        'Um tipo de ação',
        'Um fundo de investimento',
        'Uma conta corrente'
      ],
      'correctAnswer': 'Um contrato cujo valor deriva de um ativo subjacente',
    },
    {
      'question': 'O que é um hedge fund?',
      'options': [
        'Um fundo de investimento que busca retornos absolutos',
        'Um tipo de ação',
        'Um título de dívida',
        'Uma conta de poupança'
      ],
      'correctAnswer': 'Um fundo de investimento que busca retornos absolutos',
    },
    {
      'question': 'O que é um swap cambial?',
      'options': [
        'Um contrato de troca de moedas',
        'Um tipo de ação',
        'Um fundo de investimento',
        'Uma conta corrente'
      ],
      'correctAnswer': 'Um contrato de troca de moedas',
    },
    {
      'question': 'O que é um contrato futuro?',
      'options': [
        'Um acordo para comprar ou vender um ativo em uma data futura a um preço pré-determinado',
        'Um tipo de ação',
        'Um fundo de investimento',
        'Uma conta de poupança'
      ],
      'correctAnswer':
          'Um acordo para comprar ou vender um ativo em uma data futura a um preço pré-determinado',
    },
  ];

  QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int correctAnswers = 0;

  Map<int, String?> answers = {}; // Armazena as respostas do usuário
  Stopwatch timer = Stopwatch();

  @override
  void initState() {
    super.initState();
    timer.start(); // Inicia o temporizador
    // Inicializa o mapa de respostas como null
    for (int i = 0; i < widget.questions.length; i++) {
      answers[i] = null;
    }
  }

  void _answerQuestion(String selectedOption) {
    setState(() {
      answers[currentQuestionIndex] = selectedOption;
      if (selectedOption ==
          widget.questions[currentQuestionIndex]['correctAnswer']) {
        correctAnswers++;
      }
    });
  }

  void _confirmFinish() {
    timer.stop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: Colors.black,
        title: const Text(
          "Finalizar Quiz",
          style: TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Você tem certeza de que deseja finalizar o quiz?",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    timer.start(); // Retoma o temporizador
                  },
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showResults();
                  },
                  child: const Text(
                    "Finalizar",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showResults() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResultScreen(
          incorrectAnswers: widget.questions.length -
              correctAnswers -
              answers.values.where((response) => response == null).length,
          correctAnswers: correctAnswers,
          totalQuestions: widget.questions.length,
          unansweredQuestions:
              answers.values.where((response) => response == null).length,
          totalTime: timer.elapsed,
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void _showGabarito() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Questões respondidas",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: widget.questions.length,
                itemBuilder: (context, index) {
                  bool isAnswered = answers[index] != null;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isAnswered ? Colors.green : Colors.grey,
                      child: isAnswered
                          ? const Icon(Icons.check, color: Colors.white)
                          : null,
                    ),
                    title: Text("Questão ${index + 1}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[currentQuestionIndex];
    String? selectedOption = answers[currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
            "Questão ${currentQuestionIndex + 1}/${widget.questions.length}",
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Pergunta
            Text(
              currentQuestion['question'],
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 16),

            // Opções
            ...currentQuestion['options'].map<Widget>((option) {
              bool isSelected = option == selectedOption;
              return GestureDetector(
                onTap: () => _answerQuestion(option),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.orange : Colors.grey[800],
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: isSelected
                          ? Colors.grey[850] ?? Colors.grey
                          : Colors.white,
                      width: 2.0,
                    ),
                  ),
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              );
            }).toList(),

            const Spacer(),
            // Atualiza o cronômetro a cada segundo
            StreamBuilder<int>(
              stream: Stream.periodic(const Duration(seconds: 1), (i) => i),
              builder: (context, snapshot) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Tempo: ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        TextSpan(
                          text: _formatDuration(timer.elapsed),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Rodapé com navegação e gabarito
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Ir para a primeira questão
                  if (currentQuestionIndex == widget.questions.length - 1)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () {
                        setState(() {
                          currentQuestionIndex = 0;
                        });
                      },
                      child: const Text("Primeira Questão",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  const SizedBox(width: 6),
                  // Voltar
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    onPressed: currentQuestionIndex > 0
                        ? () {
                            setState(() {
                              currentQuestionIndex--;
                            });
                          }
                        : null,
                    child: const Text("Voltar",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 8),
                  // Gabarito
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    onPressed: _showGabarito,
                    child: const Text("Gabarito",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 8),
                  // Pular / Próximo / Confirmar
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    onPressed:
                        currentQuestionIndex < widget.questions.length - 1
                            ? () {
                                setState(() {
                                  currentQuestionIndex++;
                                });
                              }
                            : _confirmFinish,
                    child: Text(
                        currentQuestionIndex < widget.questions.length - 1
                            ? "Próxima"
                            : "Finalizar",
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 8),
                  // Ir para a última questão
                  if (currentQuestionIndex == 0)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () {
                        setState(() {
                          currentQuestionIndex = widget.questions.length - 1;
                        });
                      },
                      child: const Text("Última Questão",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
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

class QuizResultScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final int unansweredQuestions;
  final int incorrectAnswers;
  final Duration totalTime;

  const QuizResultScreen({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.unansweredQuestions,
    required this.incorrectAnswers,
    required this.totalTime,
  });

  int _calculateXP() {
    int baseXP = correctAnswers * 20; // Cada resposta correta vale 10 XP
    int timePenalty = (totalTime.inMinutes > 10)
        ? (totalTime.inMinutes - 2) * 2
        : 0; // Penalidade de 2 XP por minuto acima de 2 minutos
    return baseXP - timePenalty;
  }

  @override
  Widget build(BuildContext context) {
    int totalXP = _calculateXP();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const Text(
              "Parabéns! \nVocê completou o quiz.",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.help_outline, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          "Questões não respondidas: $unansweredQuestions",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.check_circle_outline,
                            color: Colors.green),
                        const SizedBox(width: 8),
                        Text(
                          "Respostas corretas: $correctAnswers",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.cancel_outlined, color: Colors.red),
                        const SizedBox(width: 8),
                        Text(
                          "Respostas incorretas: $incorrectAnswers",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.timer, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          "Tempo total: ${totalTime.inMinutes} min e ${totalTime.inSeconds % 60} seg",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Ganhos totais: $totalXP ",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const Text(
                          "XP",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Ação ao clicar no botão
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          padding: const EdgeInsets.all(16.0),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "Respostas do Quiz",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange),
                                ),
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                      );
                    },
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 24.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.checklist, color: Colors.white),
                      label: const Text(
                        "Ver Respostas",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.white, size: 20),
              label: const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  "Início",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
