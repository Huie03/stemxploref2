import 'package:flutter/material.dart';
import 'highlight.dart';
import '../widgets/solid_background.dart';
import 'package:provider/provider.dart';
import '/navigation_provider.dart';
import 'package:stemxploref2/widgets/curved_navigation_bar.dart';
import 'package:flutter_localization/flutter_localization.dart';

class HighlightDetailPage extends StatelessWidget {
  static const routeName = '/highlight-detail';
  final Highlight highlight;
  const HighlightDetailPage({super.key, required this.highlight});

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;

    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';

    final String displayTitle = isEnglish ? highlight.title : highlight.titleMs;
    final Map<String, List<String>> displayDetails = isEnglish
        ? highlight.details
        : highlight.detailsMs;
    final String appBarTitle = isEnglish ? 'STEM Highlights' : 'Sorotan STEM';

    return Scaffold(
      body: SolidBackground(
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                title: Text(
                  appBarTitle,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                scrolledUnderElevation: 0,
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
                      },
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<String>(
                          value: 'en',
                          child: Row(
                            children: [
                              const Text(
                                'English (Default)',
                                style: TextStyle(fontSize: 15),
                              ),
                              if (isEnglish) ...[
                                const Spacer(),
                                const Icon(
                                  Icons.check_circle,
                                  size: 20,
                                  color: Colors.green,
                                ),
                              ],
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
                              if (!isEnglish) ...[
                                const Spacer(),
                                const Icon(
                                  Icons.check_circle,
                                  size: 20,
                                  color: Colors.green,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        displayTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                highlight.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ...displayDetails.entries.map((entry) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.key,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ...entry.value.map((point) {
                                    final bool isImage = point.contains(
                                      'assets/images/',
                                    );
                                    final bool isBlank = point.trim().isEmpty;
                                    final bool isName =
                                        point.length < 20 &&
                                        !point.endsWith('.');

                                    if (isImage) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          child: Image.asset(point),
                                        ),
                                      );
                                    } else if (isBlank) {
                                      return const SizedBox(height: 12);
                                    } else {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          left: 8,
                                          top: isName ? 6 : 4,
                                          bottom: 2,
                                        ),
                                        child: Text(
                                          isName ? point : '• $point',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: isName
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                                  const Divider(height: 30),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
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
}
