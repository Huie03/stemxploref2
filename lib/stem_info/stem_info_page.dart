import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:stemxploref2/widgets/language_toggle.dart';
import '../widgets/rawscrollbar.dart';
import '../widgets/box_shadow.dart';
import 'package:stemxploref2/theme_provider.dart';
import 'package:provider/provider.dart';

class StemInfoPage extends StatefulWidget {
  static const routeName = '/stem-info';
  final Function(Map<String, String>) onSelect;

  const StemInfoPage({super.key, required this.onSelect});
  @override
  State<StemInfoPage> createState() => _StemInfoPageState();
}

class _StemInfoPageState extends State<StemInfoPage> {
  final ScrollController _scrollController = ScrollController();

  static const List<Map<String, String>> stemData = [
    {
      'type': 'video',
      'title_en': 'Video: STEM Meaning',
      'title_ms': 'Video: Maksud STEM',
      'preview_en':
          'Learn what STEM means and how Science, Technology, Engineering, and Math work together. '
          'See simple examples of how STEM is used in real life.\n\n'
          'This video also shows how students can apply STEM concepts in everyday activities and projects, '
          'making learning fun and interactive.',
      'preview_ms':
          'Ketahui maksud STEM dan bagaimana Sains, Teknologi, Kejuruteraan, dan Matematik berfungsi bersama. '
          'Lihat contoh mudah bagaimana STEM digunakan dalam kehidupan sebenar.\n\n'
          'Video ini juga menunjukkan bagaimana pelajar boleh menggunakan konsep STEM dalam aktiviti dan projek harian, '
          'membuat pembelajaran menjadi menyeronokkan dan interaktif.',
      'videoUrl': 'https://youtu.be/wRV28EOCGGo?si=i7nfreNgNU1jF1J8',
      'previewImage': 'assets/stem_info/STEM_video1.png',
      'source_en': 'What is STEM? – STEM Best Practice, 20 June 2017',
      'source_ms': 'Apakah itu STEM? – STEM Best Practice, 20 Jun 2017',
    },
    {
      'type': 'image',
      'title_en': 'Importance of STEM',
      'title_ms': 'Kepentingan STEM',
      'preview_en':
          'STEM is important because it helps students understand the world, encourages innovation, and equips them with skills for modern jobs.',
      'preview_ms':
          'STEM adalah penting kerana ia membantu murid memahami dunia, menggalakkan inovasi, dan melengkapi mereka dengan kemahiran untuk kerjaya moden.',
      'detailImage_en': 'assets/stem_info/Info2_en.png',
      'detailImage_ms': 'assets/stem_info/Info2_ms.png',
    },
    {
      'type': 'image',
      'title_en': 'STEM Careers',
      'title_ms': 'Kerjaya STEM',
      'previewImage': 'assets/stem_info/info3.png',
      'detailImage_en': 'assets/stem_info/Info3_en.png',
      'detailImage_ms': 'assets/stem_info/Info3_ms.png',
    },
    {
      'type': 'image',
      'title_en': 'STEM in Every Day',
      'title_ms': 'STEM dalam Kehidupan Seharian',
      'previewImage': 'assets/stem_info/info4.png',
      'detailImage_en': 'assets/stem_info/Info4_en.png',
      'detailImage_ms': 'assets/stem_info/Info4_ms.png',
    },
    {
      'type': 'video',
      'title_en': 'Video: The Most Fun STEM Projects',
      'title_ms': 'Video: Projek STEM Paling Seronok',
      'preview_en':
          'This video shows how Science, Technology, Engineering, and Math work together to solve real-world problems.\n\n'
          'See examples of STEM in everyday life and how students can explore STEM through fun projects and challenges.',
      'preview_ms':
          'Video ini menunjukkan bagaimana Sains, Teknologi, Kejuruteraan, dan Matematik bekerja bersama untuk menyelesaikan masalah dunia sebenar.\n\n'
          'Lihat contoh STEM dalam kehidupan seharian dan bagaimana pelajar boleh meneroka STEM melalui projek dan cabaran yang menyeronokkan.',
      'videoUrl': 'https://www.youtube.com/watch?v=Ml52O3miJKw',
      'previewImage': 'assets/stem_info/STEMvideo2.png',
      'source_en':
          'The Most Fun STEM Projects - GUITAR KIT WORLD, \n6 Jul 2023',
      'source_ms':
          'Projek STEM Paling Menarik - GUITAR KIT WORLD, \n6 Jul 2023',
    },
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDark = themeProvider.isDarkMode;

    final Color textColor = Theme.of(context).colorScheme.onSurface;
    final Color cardBg = Theme.of(context).colorScheme.surface;
    final Color subTextColor = isDark ? Colors.white70 : Colors.black87;
    final Color actionColor = isDark ? Colors.redAccent : Colors.redAccent;

    final String lang =
        FlutterLocalization.instance.currentLocale?.languageCode ?? 'en';
    final String appBarTitle = lang == 'en' ? 'STEM Info' : 'Maklumat STEM';

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      appBarTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: textColor,
                      ),
                    ),
                    const LanguageToggle(),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: AppRawScrollbar(
                    controller: _scrollController,
                    child: ListView.builder(
                      controller: _scrollController,

                      padding: const EdgeInsets.fromLTRB(28, 13, 18, 16),
                      itemCount: stemData.length,
                      itemBuilder: (context, index) {
                        final item = stemData[index];
                        final String title =
                            item['title_$lang'] ?? item['title_en']!;
                        final String? preview =
                            item['preview_$lang'] ?? item['preview_en'];

                        return GestureDetector(
                          onTap: () => widget.onSelect(item),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 18),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: cardBg,
                              boxShadow: isDark ? [] : appBoxShadow,
                              borderRadius: BorderRadius.circular(24),
                              border: isDark
                                  ? Border.all(
                                      color: Colors.white10,
                                      width: 0.5,
                                    )
                                  : null,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        title,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      lang == 'en' ? 'Read more' : 'Baca lagi',
                                      style: TextStyle(
                                        color: actionColor,
                                        fontWeight: FontWeight.bold,
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
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                else if (preview != null)
                                  Text(
                                    preview,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: subTextColor),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
