import 'package:flutter/material.dart';
import 'package:stemxploref2/widgets/solid_background.dart';
import '/stem_highlights/highlight.dart';
import '/stem_highlights/highlight_detail_page.dart';
import '/stem_info/stem_info_page.dart';
import '/learning_materials/learning_materials_page.dart';
import '/quiz_game/quiz_game_page.dart';
import 'stem_careers_page.dart';
import '/daily_challenge/daily_challenge_page.dart';
import 'faq_page.dart';
import 'package:flutter_localization/flutter_localization.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Highlight> highlights = sampleHighlights;
  final ScrollController _scrollController = ScrollController();

  String _getTranslatedText(String key, bool isEnglish) {
    final Map<String, Map<String, String>> localizedValues = {
      'stemInfo': {'en': 'STEM Info', 'ms': 'Info STEM'},
      'learning': {'en': 'Learning Material', 'ms': 'Bahan Pembelajaran'},
      'quiz': {'en': 'Quiz Game', 'ms': 'Permainan Kuiz'},
      'careers': {'en': 'STEM Careers', 'ms': 'Kerjaya STEM'},
      'challenge': {'en': 'Daily Challenge', 'ms': 'Cabaran Harian'},
      'faq': {'en': 'FAQ', 'ms': 'Soalan Lazim'},
      'highlights': {'en': 'STEM Highlights:', 'ms': 'Sorotan STEM:'},
      'readMore': {'en': 'Read more', 'ms': 'Baca lagi'},
    };
    return localizedValues[key]?[isEnglish ? 'en' : 'ms'] ?? key;
  }

  void _scrollList(double offset) {
    _scrollController.animateTo(
      _scrollController.offset + offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    // Add this listener
    FlutterLocalization.instance.onTranslatedLanguage = _onLanguageChanged;
  }

  // This function will be called whenever translate() is called anywhere in the app
  void _onLanguageChanged(Locale? locale) {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    FlutterLocalization.instance.onTranslatedLanguage = null;
    super.dispose();
  }

  PopupMenuItem<String> _buildPopupMenuItem(
    String value,
    String text,
    bool isSelected,
  ) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Text(text, style: const TextStyle(fontSize: 15)),
          if (isSelected) const Spacer(),
          if (isSelected)
            const Icon(Icons.check_circle, size: 20, color: Colors.green),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;

    // This line is the secret: it ensures the widget rebuilds when language changes
    // if you are using the standard flutter_localization setup.
    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';

    // Helper to get text from your existing map logic,
    // but we ensure it's called during build.
    String translate(String key) {
      final Map<String, Map<String, String>> localizedValues = {
        'stemInfo': {'en': 'STEM Info', 'ms': 'Info STEM'},
        'learning': {'en': 'Learning Material', 'ms': 'Bahan Pembelajaran'},
        'quiz': {'en': 'Quiz Game', 'ms': 'Permainan Kuiz'},
        'careers': {'en': 'STEM Careers', 'ms': 'Kerjaya STEM'},
        'challenge': {'en': 'Daily Challenge', 'ms': 'Cabaran Harian'},
        'faq': {'en': 'FAQ', 'ms': 'Soalan Lazim'},
        'highlights': {'en': 'STEM Highlights:', 'ms': 'Sorotan STEM:'},
        'readMore': {'en': 'Read more', 'ms': 'Baca lagi'},
      };
      return localizedValues[key]?[isEnglish ? 'en' : 'ms'] ?? key;
    }

    return Scaffold(
      body: SolidBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(isEnglish, localization),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    bottom: 8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 3,
                        child: GridView.count(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.3,
                          physics:
                              const NeverScrollableScrollPhysics(), // Disables internal scroll
                          children: [
                            _FeatureButton(
                              label: translate('stemInfo'), // Use the helper
                              icon: Icons.science,
                              imageAsset: 'assets/icons/1.png',
                              onTap: () => Navigator.of(
                                context,
                              ).pushNamed(StemInfoPage.routeName),
                            ),
                            _FeatureButton(
                              label: translate('learning'),
                              icon: Icons.menu_book,
                              imageAsset: 'assets/icons/2.png',
                              onTap: () => Navigator.of(
                                context,
                              ).pushNamed(LearningMaterialPage.routeName),
                            ),
                            _FeatureButton(
                              label: translate('quiz'),
                              icon: Icons.videogame_asset,
                              imageAsset: 'assets/icons/3.png',
                              onTap: () => Navigator.of(
                                context,
                              ).pushNamed(QuizGamePage.routeName),
                            ),
                            _FeatureButton(
                              label: translate('careers'),
                              icon: Icons.work,
                              imageAsset: 'assets/icons/4.png',
                              onTap: () => Navigator.of(
                                context,
                              ).pushNamed(StemCareersPage.routeName),
                            ),
                            _FeatureButton(
                              label: translate('challenge'),
                              icon: Icons.calendar_today,
                              imageAsset: 'assets/icons/5.png',
                              onTap: () => Navigator.of(
                                context,
                              ).pushNamed(DailyChallengePage.routeName),
                            ),
                            _FeatureButton(
                              label: translate('faq'),
                              icon: Icons.help_outline,
                              imageAsset: 'assets/icons/6.png',
                              onTap: () => Navigator.of(
                                context,
                              ).pushNamed(FaqPage.routeName),
                            ),
                          ],
                        ),
                      ),
                      const Divider(thickness: 1, height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              bottom: 8.0,
                            ),
                            child: Text(
                              translate('highlights'), // Use the helper
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => _scrollList(-262),
                                child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 24,
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height:
                                      120, // Reduced height to fit on screen
                                  child: ListView.separated(
                                    controller: _scrollController,
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: highlights.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(width: 12),
                                    itemBuilder: (context, index) =>
                                        _buildHighlightCard(
                                          context,
                                          highlights[index],
                                          isEnglish,
                                        ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _scrollList(262),
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Small spacer at bottom to prevent clipping
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // New Top Bar Method
  Widget _buildTopBar(bool isEnglish, FlutterLocalization localization) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Side: STEMXplore F2 Logo
          Row(
            children: [
              const Text(
                "STEMXplore ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: const Color(0xFFFFED29),
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  "F2",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),

          // Right Side: Flag Toggle with Shadow (Matching Info Page)
          PopupMenuButton<String>(
            elevation: 2,
            position: PopupMenuPosition.under,
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  key: ValueKey<bool>(isEnglish),
                  isEnglish
                      ? 'assets/flag/language us_flag.png'
                      : 'assets/flag/language ms_flag.png',
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onSelected: (value) {
              setState(() {
                localization.translate(value);
              });
            },
            itemBuilder: (context) => [
              _buildPopupMenuItem('en', 'English (Default)', isEnglish),
              _buildPopupMenuItem('ms', 'Malay', !isEnglish),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightCard(
    BuildContext context,
    Highlight h,
    bool isEnglish,
  ) {
    return GestureDetector(
      onTap: () => Navigator.of(
        context,
      ).pushNamed(HighlightDetailPage.routeName, arguments: h),
      child: Container(
        width: 260,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          // --- UPDATED BOX SHADOW ---
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2), // Slightly darker
              blurRadius: 10, // Softer spread
              spreadRadius: 1, // Extends the shadow
              offset: const Offset(0, 4), // Moves shadow down
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(16),
              ),
              child: Image.asset(
                h.image,
                width: 100,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isEnglish ? h.title : h.titleMs,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isEnglish ? h.subtitle : h.subtitleMs,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        _getTranslatedText('readMore', isEnglish),
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final String? imageAsset;

  const _FeatureButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double availableHeight = constraints.maxHeight;
        double imageSize = availableHeight * 0.60;
        double fontSize = availableHeight * 0.15;

        return Material(
          color: const Color(0xFFFFED29),
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (imageAsset != null)
                  Image.asset(
                    imageAsset!,
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.contain,
                  )
                else
                  Icon(icon, size: imageSize, color: Colors.black87),
                SizedBox(height: availableHeight * 0.05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSize.clamp(12, 16),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
