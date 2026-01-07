// pages/daily_challenge_page.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stemxploref2/widgets/solid_background.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '/navigation_provider.dart';
import 'package:stemxploref2/widgets/curved_navigation_bar.dart';

class Challenge {
  final String titleEn;
  final String titleMs;
  final String factEn;
  final String factMs;
  final String imagePath;

  Challenge({
    required this.titleEn,
    required this.titleMs,
    required this.factEn,
    required this.factMs,
    required this.imagePath,
  });
}

class DailyChallengePage extends StatefulWidget {
  static const routeName = '/daily-challenge';
  const DailyChallengePage({super.key});

  @override
  State<DailyChallengePage> createState() => _DailyChallengePageState();
}

class _DailyChallengePageState extends State<DailyChallengePage> {
  bool _isCompleted = false;
  bool _isLoading = true;

  final List<Challenge> _challenges = [
    Challenge(
      titleEn: 'Nutrition',
      titleMs: 'Nutrisi',
      factEn:
          'Carbohydrates are the main source of energy for our body and help us stay active. '
          'Foods like rice, bread, and fruits contain carbohydrates. '
          'Eating a balanced diet helps our body grow strong and stay healthy.',

      factMs:
          'Karbohidrat adalah sumber tenaga utama bagi tubuh kita dan membantu kita kekal aktif. '
          'Makanan seperti nasi, roti dan buah-buahan mengandungi karbohidrat. '
          'Pengambilan makanan seimbang membantu tubuh kita membesar dengan sihat dan kuat.',
      imagePath: 'assets/images/nutrition.png',
    ),
    Challenge(
      titleEn: 'Biodiversity',
      titleMs: 'Kepelbagaian Biologi',
      factEn:
          'Biodiversity refers to the variety of living organisms, such as plants and animals, in a habitat and helps keep ecosystems stable. '
          'Forests with many different species are usually healthier. '
          'Protecting biodiversity helps ensure food, clean air, and clean water for humans.',
      factMs:
          'Kepelbagaian biologi merujuk kepada kepelbagaian organisma hidup seperti tumbuhan dan haiwan dalam sesuatu habitat dan membantu mengekalkan kestabilan ekosistem. '
          'Hutan yang mempunyai pelbagai spesies biasanya lebih sihat. '
          'Melindungi kepelbagaian biologi membantu memastikan bekalan makanan, udara bersih dan air bersih untuk manusia.',
      imagePath: 'assets/images/biodiversity.png',
    ),
    Challenge(
      titleEn: 'Ecosystem',
      titleMs: 'Ekosistem',
      factEn:
          'An ecosystem is a community of living organisms interacting with each other and with non-living components like water, air, and soil. '
          'Examples of ecosystems include forests, rivers, and oceans. '
          'If one part of an ecosystem is damaged, it can affect all living things in that area.',

      factMs:
          'Ekosistem ialah komuniti organisma hidup yang berinteraksi antara satu sama lain dan dengan komponen bukan hidup seperti air, udara dan tanah. '
          'Contoh ekosistem termasuk hutan, sungai dan lautan. '
          'Jika satu bahagian ekosistem rosak, ia boleh memberi kesan kepada semua hidupan di kawasan tersebut.',
      imagePath: 'assets/images/ecosystem.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _checkTodayStatus();
  }

  String _getTodayKey() {
    final now = DateTime.now();
    return "challenge_${now.year}_${now.month}_${now.day}";
  }

  Future<void> _checkTodayStatus() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _isCompleted = prefs.getBool(_getTodayKey()) ?? false;
      _isLoading = false;
    });
  }

  Future<void> _handleComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_getTodayKey(), true);
    if (!mounted) return;
    setState(() {
      _isCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final bool isEnglish = localization.currentLocale?.languageCode == 'en';

    final int dayIndex = DateTime.now().day % _challenges.length;
    final currentChallenge = _challenges[dayIndex];
    final String title = isEnglish ? 'Daily Challenge' : 'Cabaran Harian';

    return Scaffold(
      body: SolidBackground(
        child: SafeArea(
          child: Column(
            children: [
              // --- MATCHING CUSTOM APP BAR ---
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 50), // Balance for the flag
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                    PopupMenuButton<String>(
                      elevation: 2,
                      position: PopupMenuPosition.under,
                      icon: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
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
                        _buildPopupMenuItem(
                          'en',
                          'English (Default)',
                          isEnglish,
                        ),
                        _buildPopupMenuItem('ms', 'Malay', !isEnglish),
                      ],
                    ),
                  ],
                ),
              ),

              // --- END APP BAR ---
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 25,
                              ), // MOVED SLIGHTLY BELOW
                              // CHALLENGE CARD
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    255,
                                    255,
                                    255,
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(color: Colors.black12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.35,
                                      ),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      isEnglish
                                          ? 'STEM Fact of the Day – ${currentChallenge.titleEn}'
                                          : 'Fakta STEM Hari Ini – ${currentChallenge.titleMs}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        currentChallenge.imagePath,
                                        height: 160,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        isEnglish
                                            ? 'Did you know?'
                                            : 'Tahukah anda?',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      isEnglish
                                          ? currentChallenge.factEn
                                          : currentChallenge.factMs,
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        height: 1.4,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: _isCompleted
                                          ? null
                                          : _handleComplete,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        foregroundColor: Colors.white,
                                        minimumSize: const Size(
                                          double.infinity,
                                          50,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        _isCompleted
                                            ? (isEnglish
                                                  ? 'Challenge Finished'
                                                  : 'Cabaran Selesai')
                                            : (isEnglish
                                                  ? 'Complete Challenge'
                                                  : 'Selesaikan Cabaran'),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 28),

                              // SUCCESS MESSAGE
                              if (_isCompleted)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(24),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.35,
                                          ),
                                          blurRadius: 12,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          color: Color.fromARGB(
                                            255,
                                            93,
                                            241,
                                            98,
                                          ),
                                          size: 40,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          isEnglish ? 'Well done!' : 'Syabas!',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          isEnglish
                                              ? 'You completed today\'s challenge.'
                                              : 'Anda telah menyelesaikan cabaran hari ini.',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
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

  // Helper method for Language Popup
  PopupMenuItem<String> _buildPopupMenuItem(
    String value,
    String text,
    bool isSelected,
  ) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Text(text, style: const TextStyle(fontSize: 14)),
          if (isSelected) ...[
            const Spacer(),
            const Icon(Icons.check_circle, color: Colors.green, size: 20),
          ],
        ],
      ),
    );
  }
}
