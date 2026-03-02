import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '../widgets/gradient_background.dart';
import '../widgets/language_toggle.dart';
import '../widgets/box_shadow.dart';
import 'package:stemxploref2/theme_provider.dart';
import 'package:provider/provider.dart';

class QuizGamePage extends StatefulWidget {
  final Function(String) selected;
  final VoidCallback? onBackOverride;

  const QuizGamePage({super.key, required this.selected, this.onBackOverride});

  @override
  State<QuizGamePage> createState() => _QuizGamePageState();
}

class _QuizGamePageState extends State<QuizGamePage> {
  String? _expandedSubject;

  final List<Map<String, String>> materials = const [
    {"title": "Science", "image": 'assets/textbook/Science/BC_Science.jpg'},
    {
      "title": "Mathematics",
      "image": 'assets/textbook/Mathematics/BC_Mathematics.jpg',
    },
    {
      "title": "Computer Science (ASK)",
      "image": 'assets/textbook/ASK/BC_ASK.jpg',
    },
    {
      "title": "Design and Technology (RBT)",
      "image": 'assets/textbook/RBT/BC_RBT.jpg',
    },
  ];

  void _toggleExpand(String title) {
    setState(() {
      _expandedSubject = (_expandedSubject == title) ? null : title;
    });
  }

  String _translateTitle(String title, bool isEnglish) {
    if (isEnglish) return title;
    switch (title) {
      case "Science":
        return "Sains";
      case "Mathematics":
        return "Matematik";
      case "Computer Science (ASK)":
        return "Asas Sains Komputer (ASK)";
      case "Design and Technology (RBT)":
        return "Reka Bentuk dan Teknologi (RBT)";
      default:
        return title;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDark = themeProvider.isDarkMode;

    final Color textColor = Theme.of(context).colorScheme.onSurface;
    final Color cardBg = Theme.of(context).colorScheme.surface;

    final FlutterLocalization localization = FlutterLocalization.instance;
    final bool isEnglish =
        localization.currentLocale?.languageCode == 'en' ||
        localization.currentLocale == null;

    final String pageTitle = isEnglish ? 'Quiz Game' : 'Permainan Kuiz';

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCustomAppBar(pageTitle, textColor),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  itemCount: materials.length,
                  itemBuilder: (context, index) {
                    final item = materials[index];
                    final String rawTitle = item['title']!;
                    final bool isExpanded = _expandedSubject == rawTitle;

                    return _buildExpandableMaterialCard(
                      context,
                      isDark: isDark,
                      cardBg: cardBg,
                      textColor: textColor,
                      title: _translateTitle(rawTitle, isEnglish),
                      rawTitle: rawTitle,
                      imagePath: item['image']!,
                      isExpanded: isExpanded,
                      isEnglish: isEnglish,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(String title, Color textColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: textColor,
            ),
          ),
          LanguageToggle(onLanguageChanged: () => setState(() {})),
        ],
      ),
    );
  }

  Widget _buildExpandableMaterialCard(
    BuildContext context, {
    required bool isDark,
    required Color cardBg,
    required Color textColor,
    required String title,
    required String rawTitle,
    required String imagePath,
    required bool isExpanded,
    required bool isEnglish,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _toggleExpand(rawTitle),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: isExpanded
                  ? const BorderRadius.vertical(top: Radius.circular(20))
                  : BorderRadius.circular(20),
              border: isDark
                  ? Border.all(color: Colors.white10, width: 0.5)
                  : null,
              boxShadow: isExpanded || isDark ? [] : appBoxShadow,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: textColor,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                SizedBox(
                  height: 85,
                  width: 65,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (c, e, s) => Icon(
                      Icons.book,
                      size: 50,
                      color: isDark ? Colors.white54 : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: isExpanded ? 220 : 0,
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
            border: isDark
                ? const Border(
                    left: BorderSide(color: Colors.white10, width: 0.5),
                    right: BorderSide(color: Colors.white10, width: 0.5),
                    bottom: BorderSide(color: Colors.white10, width: 0.5),
                  )
                : null,
            boxShadow: isExpanded && !isDark ? appBoxShadow : [],
          ),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                children: [
                  _buildModeButton(
                    isEnglish ? "EASY MODE" : "MOD MUDAH",
                    const Color(0xFF2ECC71), //Soft Green
                    rawTitle,
                    isDark,
                  ),
                  _buildModeButton(
                    isEnglish ? "MEDIUM MODE" : "MOD SEDERHANA",
                    const Color(0xFFF1C40F), //Warm Yellow
                    rawTitle,
                    isDark,
                  ),
                  _buildModeButton(
                    isEnglish ? "HARD MODE" : "MOD SUKAR",
                    const Color(0xFFE74C3C), //Soft Red
                    rawTitle,
                    isDark,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildModeButton(
    String label,
    Color color,
    String subject,
    bool isDark,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.black,
          elevation: isDark ? 0 : 4,
          shadowColor: Colors.black.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: () {
          widget.selected("$subject|$label");
        },
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
