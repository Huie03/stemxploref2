import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import '../widgets/box_shadow.dart';

class PlayQuizPage extends StatefulWidget {
  final String subjectAndMode;
  final VoidCallback onFinish;

  const PlayQuizPage({
    super.key,
    required this.subjectAndMode,
    required this.onFinish,
  });

  @override
  State<PlayQuizPage> createState() => _PlayQuizPageState();
}

class _PlayQuizPageState extends State<PlayQuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  late String _subject;
  late String _difficulty;

  final Map<String, Map<String, List<Map<String, dynamic>>>> _quizData = {
    "Science": {
      "EASY MODE": [
        {
          "q": "What is the basic unit of life?",
          "options": ["Atom", "Cell", "Tissue", "Organ"],
          "answer": 1,
        },
        {
          "q": "Which planet is known as the Red Planet?",
          "options": ["Venus", "Mars", "Jupiter", "Saturn"],
          "answer": 1,
        },
      ],
      "MEDIUM MODE": [
        {
          "q":
              "Which gas do plants absorb from the atmosphere for photosynthesis?",
          "options": ["Oxygen", "Nitrogen", "Carbon Dioxide", "Hydrogen"],
          "answer": 2,
        },
      ],
      "HARD MODE": [
        {
          "q": "What is the chemical symbol for Tungsten?",
          "options": ["Tu", "W", "Tg", "Tn"],
          "answer": 1,
        },
      ],
    },
    "Mathematics": {
      "EASY MODE": [
        {
          "q": "What is 5 + 7?",
          "options": ["10", "11", "12", "13"],
          "answer": 2,
        },
      ],
      "MEDIUM MODE": [
        {
          "q": "What is the square root of 144?",
          "options": ["10", "11", "12", "14"],
          "answer": 2,
        },
      ],
      "HARD MODE": [
        {
          "q": "Solve for x: 2x + 5 = 15",
          "options": ["x=5", "x=10", "x=2.5", "x=7"],
          "answer": 0,
        },
      ],
    },
    "Computer Science (ASK)": {
      "EASY MODE": [
        {
          "q": "What does RAM stand for?",
          "options": [
            "Read Access Memory",
            "Random Access Memory",
            "Run Allied Media",
          ],
          "answer": 1,
        },
      ],
      "MEDIUM MODE": [
        {
          "q": "Which of these is an input device?",
          "options": ["Monitor", "Printer", "Scanner", "Speaker"],
          "answer": 2,
        },
      ],
      "HARD MODE": [
        {
          "q": "What is the decimal value of the binary number 1011?",
          "options": ["9", "10", "11", "13"],
          "answer": 2,
        },
      ],
    },
    "Design and Technology (RBT)": {
      "EASY MODE": [
        {
          "q": "Which tool is used for soldering?",
          "options": ["Hammer", "Soldering Iron", "Saw"],
          "answer": 1,
        },
      ],
      "MEDIUM MODE": [
        {
          "q": "What type of motion does a piston in an engine show?",
          "options": ["Linear", "Reciprocating", "Rotary", "Oscillating"],
          "answer": 1,
        },
      ],
      "HARD MODE": [
        {
          "q": "Which electronic component is used to store electrical charge?",
          "options": ["Resistor", "Transistor", "Capacitor", "Diode"],
          "answer": 2,
        },
      ],
    },
  };

  @override
  void initState() {
    super.initState();

    final parts = widget.subjectAndMode.split('|');
    _subject = parts[0];

    String rawMode = parts.length > 1 ? parts[1].toUpperCase() : "EASY MODE";

    if (rawMode.contains("MUDAH") || rawMode.contains("EASY"))
      _difficulty = "EASY MODE";
    else if (rawMode.contains("SEDERHANA") || rawMode.contains("MEDIUM"))
      _difficulty = "MEDIUM MODE";
    else if (rawMode.contains("SUKAR") || rawMode.contains("HARD"))
      _difficulty = "HARD MODE";
    else
      _difficulty = "EASY MODE";
  }

  void _handleAnswer(int selectedIndex) {
    final questions = _quizData[_subject]?[_difficulty] ?? [];
    if (selectedIndex == questions[_currentQuestionIndex]['answer']) {
      _score++;
    }

    setState(() {
      if (_currentQuestionIndex < questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _showResultDialog();
      }
    });
  }

  void _showResultDialog() {
    final questions = _quizData[_subject]?[_difficulty] ?? [];
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "Quiz Finished!",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.emoji_events, color: Colors.amber, size: 60),
            const SizedBox(height: 10),
            Text("Subject: $_subject"),
            Text("Mode: $_difficulty"),
            const SizedBox(height: 10),
            Text(
              "Your score: $_score / ${questions.length}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onFinish();
            },
            child: const Text(
              "CLOSE",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final questions = _quizData[_subject]?[_difficulty] ?? [];

    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: widget.onFinish,
          ),
        ),
        body: const Center(
          child: Text("No questions available for this level."),
        ),
      );
    }

    final currentQuestion = questions[_currentQuestionIndex];

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: widget.onFinish,
                    ),
                    Text(
                      "$_subject - $_difficulty",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      "${_currentQuestionIndex + 1}/${questions.length}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                LinearProgressIndicator(
                  value: (_currentQuestionIndex + 1) / questions.length,
                  backgroundColor: Colors.black12,
                  color: Colors.blue,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 40),
                // Question Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: appBoxShadow,
                  ),
                  child: Text(
                    currentQuestion['q'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                // Options
                ...List.generate(
                  currentQuestion['options'].length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.all(18),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () => _handleAnswer(index),
                      child: Text(
                        currentQuestion['options'][index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
