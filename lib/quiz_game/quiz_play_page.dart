//quiz_play_game
import 'package:flutter/material.dart';
import 'package:stemxploref2/widgets/solid_background.dart';
import 'package:provider/provider.dart';
import '/navigation_provider.dart';
import 'package:stemxploref2/widgets/curved_navigation_bar.dart';

enum QuizMode { playing, results, reviewing }

class QuizPlayPage extends StatefulWidget {
  const QuizPlayPage({super.key});

  @override
  State<QuizPlayPage> createState() => _QuizPlayPageState();
}

class _QuizPlayPageState extends State<QuizPlayPage> {
  QuizMode _mode = QuizMode.playing;
  String selectedOption = "";

  // WHITE CARD WITH STROKE
  Widget _whiteCardContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.70),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SolidBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildSimpleHeader(),
              if (_mode == QuizMode.results || _mode == QuizMode.reviewing)
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Time taken: 4 min 30 sec.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 50),
                  child: _buildBody(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppCurvedNavBar(
        currentIndex: 0,
        onTap: (index) {
          Provider.of<NavigationProvider>(
            context,
            listen: false,
          ).setIndex(index);
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }

  Widget _buildSimpleHeader() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        "Quiz Game",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildBody() {
    switch (_mode) {
      case QuizMode.playing:
        return _whiteCardContainer(child: _questionContent());
      case QuizMode.results:
        return _whiteCardContainer(child: _resultsContent());
      case QuizMode.reviewing:
        return _whiteCardContainer(child: _reviewContent());
    }
  }

  // CONTENT QUESTION
  Widget _questionContent() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Science Form 2",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("15/15", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Which of the following is a macronutrient?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 45),
                GestureDetector(
                  onTap: () => setState(() => selectedOption = "Vitamin C"),
                  child: _option(
                    "Vitamin C",
                    isSelected: selectedOption == "Vitamin C",
                  ),
                ),
                const SizedBox(height: 15),

                GestureDetector(
                  onTap: () => setState(() => selectedOption = "Protein"),
                  child: _option(
                    "Protein",
                    isSelected: selectedOption == "Protein",
                  ),
                ),
                const SizedBox(height: 15),

                GestureDetector(
                  onTap: () => setState(() => selectedOption = "Iron"),
                  child: _option("Iron", isSelected: selectedOption == "Iron"),
                ),
                const SizedBox(height: 15),

                GestureDetector(
                  onTap: () => setState(() => selectedOption = "Vitamin D"),
                  child: _option(
                    "Vitamin D",
                    isSelected: selectedOption == "Vitamin D",
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),

        _actionButtons("Next", () {
          if (selectedOption.isNotEmpty) {
            setState(() => _mode = QuizMode.results);
          }
        }),
      ],
    );
  }

  // CONTENT: RESULTS
  Widget _resultsContent() {
    return Column(
      children: [
        const SizedBox(height: 40),
        const Text(
          "Quiz completed!",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          "Score: 13 / 15",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        const Text("Time taken: 4 min 30 sec.", style: TextStyle(fontSize: 18)),
        const SizedBox(height: 40),
        const Text(
          "Well done!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Text(
          "You completed the quiz in 4 min 30 sec.\nKeep it up!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const Spacer(),

        Row(
          children: [
            Expanded(
              child: _largeNavButton(
                "Check\nAnswer",
                () => setState(() => _mode = QuizMode.reviewing),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _largeNavButton(
                "Replay",
                () => setState(() => _mode = QuizMode.playing),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _largeNavButton("Done", () => Navigator.pop(context)),
            ),
          ],
        ),
      ],
    );
  }

  // CONTENT: REVIEW
  Widget _reviewContent() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Science Form 2",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("15/15", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),

        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 30),
                // Question Text
                const Text(
                  "Which of the following is a macronutrient?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Your answer is correct!",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Options
                _reviewOption("Vitamin C", Colors.redAccent),
                const SizedBox(height: 12),
                _reviewOption("Protein", Colors.greenAccent[400]!),
                const SizedBox(height: 12),
                _reviewOption("Iron", Colors.redAccent),
                const SizedBox(height: 12),
                _reviewOption("Vitamin D", Colors.redAccent),

                const SizedBox(height: 30),

                // Explanation Section
                const Divider(color: Colors.black26, thickness: 1),
                const SizedBox(height: 15),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Explanation:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Macronutrients are nutrients required in large amounts for energy and growth: carbohydrates, proteins, and fats. Vitamins and minerals are micronutrients needed in smaller amounts.",
                  style: TextStyle(fontSize: 14, height: 1.4),
                ),
                const SizedBox(height: 20),

                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/quiz_explanation.png',
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),

        _actionButtons("Next", () => setState(() => _mode = QuizMode.results)),
      ],
    );
  }

  // UPDATED BUTTON
  Widget _largeNavButton(
    String label,
    VoidCallback onTap, {
    double width = 120,
    double height = 50,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }

  // _option widget to handle the colors
  Widget _option(String text, {bool isSelected = false}) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Only change to grey if it is actually selected by the user
        color: isSelected ? Colors.grey[400] : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          if (!isSelected) // Only show shadow for unselected to look "pressed" when grey
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 4,
              offset: const Offset(0, 5),
            ),
        ],
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _reviewOption(String text, Color color) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _actionButtons(String nextLabel, VoidCallback onNext) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _largeNavButton(
          "Back",
          () => Navigator.pop(context),
          width: 120,
          height: 40,
        ),
        const SizedBox(width: 50),
        _largeNavButton(nextLabel, onNext, width: 120, height: 40),
      ],
    );
  }
}
