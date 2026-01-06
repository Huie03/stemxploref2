import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stemxploref2/widgets/solid_background.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '/navigation_provider.dart';
import 'package:stemxploref2/widgets/curved_navigation_bar.dart';

class FaqPage extends StatelessWidget {
  static const routeName = '/faq';
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final bool isEnglish = localization.currentLocale?.languageCode == 'en';

    // FAQ Data
    final List<Map<String, String>> faqData = isEnglish
        ? [
            {
              'q': 'Why is STEM important for students?',
              'a':
                  'STEM helps students develop thinking and problem-solving skills.',
            },
            {
              'q': 'How is STEM used in real life?',
              'a':
                  'STEM is used in healthcare, transportation, communication, and technology.',
            },
            {
              'q': 'What is the role of science in STEM?',
              'a':
                  'Science helps us understand natural phenomena through observation and experiments.',
            },
            {
              'q': 'How does technology support learning?',
              'a':
                  'Technology provides tools like apps, simulations, and online resources.',
            },
            {
              'q': 'What does engineering involve?',
              'a':
                  'Engineering focuses on designing and improving systems, tools, and structures.',
            },
            {
              'q': 'Why is mathematics important in STEM?',
              'a':
                  'Mathematics helps in calculations, measurements, and data analysis.',
            },
            {
              'q': 'What skills can students gain from STEM?',
              'a':
                  'Critical thinking, communication, and collaboration skills.',
            },
            {
              'q': 'How can students improve their STEM performance?',
              'a':
                  'By practicing, asking questions, and participating actively.',
            },
            {
              'q': 'Why should students focus on STEM?',
              'a':
                  'Because it builds strong foundations for higher learning and future careers.',
            },
            {
              'q': 'Do I need to be good at all STEM subjects?',
              'a':
                  'No. Students can be stronger in some areas and improve others with practice.',
            },
          ]
        : [
            {
              'q': 'Mengapa STEM penting untuk murid?',
              'a':
                  'STEM membantu murid membina kemahiran berfikir dan penyelesaian masalah.',
            },
            {
              'q': 'Bagaimanakah STEM digunakan dalam kehidupan?',
              'a':
                  'STEM digunakan dalam kesihatan, pengangkutan, komunikasi, dan teknologi.',
            },
            {
              'q': 'Apakah peranan sains dalam STEM?',
              'a':
                  'Sains membantu kita memahami fenomena alam melalui pemerhatian dan eksperimen.',
            },
            {
              'q': 'Bagaimanakah teknologi menyokong pembelajaran?',
              'a':
                  'Teknologi menyediakan alatan seperti aplikasi, simulasi, dan sumber dalam talian.',
            },
            {
              'q': 'Apakah yang melibatkan kejuruteraan?',
              'a':
                  'Kejuruteraan fokus kepada reka bentuk dan menambah baik sistem, alatan, dan struktur.',
            },
            {
              'q': 'Mengapa matematik penting dalam STEM?',
              'a':
                  'Matematik membantu dalam pengiraan, ukuran, dan analisis data.',
            },
            {
              'q': 'Apakah kemahiran yang diperoleh murid daripada STEM?',
              'a': 'Kemahiran berfikir kritis, komunikasi, dan kolaborasi.',
            },
            {
              'q': 'Bagaimana murid boleh meningkatkan prestasi STEM?',
              'a':
                  'Dengan berlatih, bertanya soalan, dan mengambil bahagian secara aktif.',
            },
            {
              'q': 'Mengapa murid perlu fokus kepada STEM?',
              'a':
                  'Kerana ia membina asas yang kukuh untuk pembelajaran tinggi dan kerjaya masa depan.',
            },
            {
              'q': 'Adakah saya perlu mahir dalam semua subjek STEM?',
              'a':
                  'Tidak. Murid boleh menjadi lebih kuat dalam sesetengah bidang dan memperbaiki yang lain dengan latihan.',
            },
          ];

    return Scaffold(
      body: SolidBackground(
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: Colors.transparent,
                scrolledUnderElevation: 0,
                elevation: 0,
                title: Text(
                  isEnglish ? 'Frequent Asked Questions' : 'Soalan Lazim',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: PopupMenuButton<String>(
                      color: Color.fromARGB(255, 236, 233, 233),
                      icon: Image.asset(
                        isEnglish
                            ? 'assets/flag/language us_flag.png'
                            : 'assets/flag/language ms_flag.png',
                        width: 40,
                      ),
                      offset: const Offset(0, 50),
                      onSelected: (String value) {
                        localization.translate(value);
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
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
                                  const Text(
                                    'Malay',
                                    style: TextStyle(fontSize: 15),
                                  ),
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
              ),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: faqData.length,
                  itemBuilder: (context, index) {
                    return FaqItem(
                      question: faqData[index]['q']!,
                      answer: faqData[index]['a']!,
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
}

class FaqItem extends StatefulWidget {
  final String question;
  final String answer;

  const FaqItem({super.key, required this.question, required this.answer});

  @override
  State<FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.question,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Color.fromARGB(255, 255, 255, 224),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) const SizedBox(height: 10),

          // ANSWER BOX
          if (isExpanded)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 252, 196, 74),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color.fromARGB(218, 0, 0, 0),
                  width: 1,
                ),
              ),
              child: Text(
                widget.answer,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
