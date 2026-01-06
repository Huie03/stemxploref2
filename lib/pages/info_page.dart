import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:stemxploref2/widgets/solid_background.dart';
import 'package:stemxploref2/widgets/curved_navigation_bar.dart';
import '/navigation_provider.dart';

class InfoPage extends StatefulWidget {
  static const routeName = '/info';
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final bool isEnglish = localization.currentLocale?.languageCode == 'en';

    final String title = isEnglish ? 'Info' : 'Maklumat';

    final String description = isEnglish
        ? 'STEMXplore F2 is a mobile learning application designed for Form 2 secondary school students to explore Science, Technology, Engineering and Mathematics through interactive content, videos and learning activities. STEMXplore F2 was created to help students better understand STEM concepts, increase interest in learning and show how STEM is applied in real-life situations in a fun and engaging way, while supporting Sustainable Development Goal 4 (Quality Education).'
        : 'STEMXplore F2 adalah aplikasi pembelajaran mudah alih yang direka untuk pelajar sekolah menengah Tingkatan 2 untuk meneroka Sains, Teknologi, Kejuruteraan dan Matematik melalui kandungan interaktif, video dan aktiviti pembelajaran. STEMXplore F2 dicipta untuk membantu pelajar memahami konsep STEM dengan lebih baik, meningkatkan minat dalam pembelajaran dan menunjukkan bagaimana STEM diaplikasikan dalam situasi kehidupan sebenar dengan cara yang menyeronokkan, sambil menyokong Matlamat Pembangunan Mampan 4 (Pendidikan Berkualiti).';

    return Scaffold(
      body: SolidBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildCustomAppBar(title, isEnglish, localization),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      // Main Illustration Logo
                      Image.asset(
                        'assets/images/Logo_F2.png',
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 8),
                      // Justified Description
                      Text(
                        description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 15.5,
                          height: 1.5,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Footer Logos (Kedah and UUM)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Logo_Kedah.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit
                                .contain, // Ensures the logo doesn't stretch
                          ),
                          const SizedBox(width: 30),
                          Image.asset(
                            'assets/images/Logo_UUM.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppCurvedNavBar(
        currentIndex: 2,
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

  Widget _buildCustomAppBar(
    String title,
    bool isEnglish,
    FlutterLocalization localization,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 50),
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
                  // The Key forces the flag to redraw when the language changes
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
