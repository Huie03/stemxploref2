//quiz_game_page
import 'package:flutter/material.dart';
import 'package:stemxploref2/widgets/solid_background.dart';
import 'quiz_play_page.dart';
import 'package:provider/provider.dart';
import '/navigation_provider.dart';
import 'package:stemxploref2/widgets/curved_navigation_bar.dart';
import 'package:flutter_localization/flutter_localization.dart';

class QuizGamePage extends StatefulWidget {
  static const routeName = '/quiz-game';
  const QuizGamePage({super.key});

  @override
  State<QuizGamePage> createState() => _QuizGamePageState();
}

class _QuizGamePageState extends State<QuizGamePage> {
  String selectedCategory = "All";
  final List<String> categories = [
    "All",
    "Science",
    "Mathematics",
    "Asas Sains Komputer",
    "Reka Bentuk Dan Teknologi",
  ];

  final List<Map<String, String>> quizzes = [
    {
      "title": "STEM",
      "sub": "10 questions",
      "image": "assets/images/quiz_stem.png",
      "category": "All",
    },
    {
      "title": "Mathematics Form 2",
      "sub": "15 questions",
      "image": "assets/images/math_book_cover.png",
      "category": "Mathematics",
    },
    {
      "title": "Science Form 2",
      "sub": "15 questions",
      "image": "assets/images/science_book_cover.png",
      "category": "Science",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SolidBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              _buildCategoryScroll(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: quizzes
                      .where(
                        (quiz) =>
                            selectedCategory == "All" ||
                            quiz['category'] == selectedCategory,
                      )
                      .map((quiz) {
                        return GestureDetector(
                          onTap: () {
                            if (quiz['title'] == "Science Form 2") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const QuizPlayPage(),
                                ),
                              );
                            }
                          },
                          child: _quizCard(
                            quiz['title']!,
                            quiz['sub']!,
                            quiz['image']!,
                          ),
                        );
                      })
                      .toList(),
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

  Widget _buildAppBar() {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final bool isEnglish = localization.currentLocale?.languageCode == 'en';

    return AppBar(
      title: Text(
        isEnglish ? 'Quiz Game' : 'Permainan Kuiz',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: PopupMenuButton<String>(
            color: const Color.fromARGB(255, 236, 233, 233),
            icon: Image.asset(
              isEnglish
                  ? 'assets/flag/language us_flag.png'
                  : 'assets/flag/language ms_flag.png',
              width: 40,
            ),
            offset: const Offset(0, 50),
            onSelected: (String value) {
              localization.translate(value);
              setState(() {});
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'en',
                child: Row(
                  children: [
                    const Text(
                      'English (Default)',
                      style: TextStyle(fontSize: 15),
                    ),
                    if (isEnglish) const Spacer(),
                    if (isEnglish)
                      const Icon(
                        Icons.check_circle,
                        size: 20,
                        color: Colors.green,
                      ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'ms',
                child: Row(
                  children: [
                    const Text('Malay', style: TextStyle(fontSize: 15)),
                    if (!isEnglish) const Spacer(),
                    if (!isEnglish)
                      const Icon(
                        Icons.check_circle,
                        size: 20,
                        color: Colors.green,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryScroll() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedCategory == categories[index];
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = categories[index]),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black12),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.black : Colors.black54,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _quizCard(String title, String sub, String imgPath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black.withValues(alpha: .05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  sub,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15), // Gap between text and image

          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imgPath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 100,
                height: 100,
                color: Colors.grey[200],
                child: const Icon(Icons.book, color: Colors.grey, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
