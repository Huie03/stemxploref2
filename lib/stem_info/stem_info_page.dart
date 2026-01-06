import 'package:flutter/material.dart';
import '../widgets/solid_background.dart';
import 'stem_detail_page.dart';
import 'package:provider/provider.dart';
import '/navigation_provider.dart';
import 'package:stemxploref2/widgets/curved_navigation_bar.dart';
import 'package:flutter_localization/flutter_localization.dart';

class StemInfoPage extends StatelessWidget {
  static const routeName = '/stem-info';

  const StemInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final bool isEnglish = localization.currentLocale?.languageCode == 'en';

    final List<Map<String, String>> stemData = isEnglish
        ? [
            {
              'title': 'Watch: What is STEM?',
              'preview':
                  'Learn what STEM means and how Science, Technology, Engineering, and Math work together. See simple examples of how STEM is used in real life.',
              'videoUrl': 'https://www.youtube.com/watch?v=F4Ya-etTbV0',
              'previewImage': 'assets/images/STEM_video1.png',
            },
            {
              'title': 'Applied STEM in real life',
              'preview': '',
              'previewImage': 'assets/images/STEM 2.png',
              'detailImage': 'assets/images/STEM 2.png',
            },
            {
              'title': 'Did you know importance of STEM?',
              'preview':
                  'STEM is important because it helps students understand the world, encourages innovation, and equips them with skills for modern jobs.',
              'detailImage': ' ',
            },
            {
              'title': 'STEM careers',
              'preview': '',
              'previewImage': 'assets/images/stemInfo3.png',
              'detailImage': ' ',
            },
            {
              'title': 'STEM learning activities',
              'preview': '',
              'previewImage': 'assets/images/steminfo4.png',
              'detailImage': ' ',
            },
          ]
        : [
            {
              'title': 'Tonton: Apakah itu STEM?',
              'preview':
                  'Ketahui maksud STEM dan bagaimana Sains, Teknologi, Kejuruteraan, dan Matematik bekerjasama. Lihat contoh mudah penggunaan STEM dalam kehidupan seharian.',
              'videoUrl': 'https://www.youtube.com/watch?v=F4Ya-etTbV0',
              'previewImage': 'assets/images/STEM_video1.png',
            },
            {
              'title': 'Aplikasi STEM dalam kehidupan',
              'preview': '',
              'previewImage': 'assets/images/STEM 2.png',
              'detailImage': 'assets/images/STEM 2.png',
            },
            {
              'title': 'Tahukah anda kepentingan STEM?',
              'preview':
                  'STEM adalah penting kerana ia membantu murid memahami dunia, menggalakkan inovasi, dan melengkapi mereka dengan kemahiran untuk kerjaya moden.',
              'detailImage': ' ',
            },
            {
              'title': 'Kerjaya STEM',
              'preview': '',
              'previewImage': 'assets/images/stemInfo3.png',
              'detailImage': ' ',
            },
            {
              'title': 'Aktiviti pembelajaran STEM',
              'preview': '',
              'previewImage': 'assets/images/steminfo4.png',
              'detailImage': ' ',
            },
          ];

    final String title = isEnglish ? 'STEM Info' : 'Maklumat STEM';

    return Scaffold(
      body: SolidBackground(
        child: SafeArea(
          child: Column(
            children: [
              // --- UPDATED APP BAR TO MATCH INFO PAGE ---
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 50), // Balance the flag button
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
                        localization.translate(value);
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

              // --- END OF UPDATED APP BAR ---
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: stemData.length,
                  itemBuilder: (context, index) {
                    final item = stemData[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StemDetailPage(itemIndex: index),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.35),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item['title']!,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  isEnglish ? 'Read more' : 'Baca lagi',
                                  style: const TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            if (item.containsKey('previewImage'))
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  item['previewImage']!,
                                  width: double.infinity,
                                  height: 115,
                                  fit: BoxFit.cover,
                                ),
                              )
                            else
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F1E9),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: Text(
                                  item['preview']!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
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

  // Helper method to build the popup menu items exactly like InfoPage
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
