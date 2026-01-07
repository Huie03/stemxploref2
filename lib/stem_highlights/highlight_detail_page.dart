import 'package:flutter/material.dart';
import 'highlight.dart';
import '../widgets/solid_background.dart';
import 'package:provider/provider.dart';
import '/navigation_provider.dart';
import 'package:stemxploref2/widgets/curved_navigation_bar.dart';
import 'package:flutter_localization/flutter_localization.dart';

class HighlightDetailPage extends StatefulWidget {
  static const routeName = '/highlight-detail';
  final Highlight highlight;
  const HighlightDetailPage({super.key, required this.highlight});

  @override
  State<HighlightDetailPage> createState() => _HighlightDetailPageState();
}

class _HighlightDetailPageState extends State<HighlightDetailPage> {
  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;

    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';

    final String displayTitle = isEnglish
        ? widget.highlight.title
        : widget.highlight.titleMs;
    final Map<String, List<String>> displayDetails = isEnglish
        ? widget.highlight.details
        : widget.highlight.detailsMs;
    final String appBarTitle = isEnglish ? 'STEM Highlights' : 'Sorotan STEM';

    return Scaffold(
      body: SolidBackground(
        child: SafeArea(
          child: Column(
            children: [
              // --- ADJUSTED APP BAR TO MATCH INFO PAGE ---
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 50), // Balance the flag button
                    Text(
                      appBarTitle,
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

              // --- END OF ADJUSTED APP BAR ---
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Text(
                        displayTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                widget.highlight.image,
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

  // Helper to match the InfoPage menu items
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
