import 'package:flutter/material.dart';
import 'highlight.dart';
import '../widgets/gradient_background.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '/widgets/language_toggle.dart';
import '../widgets/rawscrollbar.dart';
import '../widgets/box_shadow.dart';
import 'package:stemxploref2/theme_provider.dart';
import 'package:provider/provider.dart';

class HighlightDetailPage extends StatefulWidget {
  static const routeName = '/highlight-detail';
  final Highlight highlight;
  const HighlightDetailPage({super.key, required this.highlight});

  @override
  State<HighlightDetailPage> createState() => _HighlightDetailPageState();
}

class _HighlightDetailPageState extends State<HighlightDetailPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDark = themeProvider.isDarkMode;

    final FlutterLocalization localization = FlutterLocalization.instance;
    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';

    final Color textColor = Theme.of(context).colorScheme.onSurface;
    final Color cardBg = Theme.of(context).colorScheme.surface;
    final Color subTextColor = isDark ? Colors.white : Colors.black87;

    final String displayTitle = isEnglish
        ? widget.highlight.titleEn
        : widget.highlight.titleMs;
    final String displaySubtitle = isEnglish
        ? widget.highlight.subtitleEn
        : widget.highlight.subtitleMs;
    final List<String> displayDetails = isEnglish
        ? widget.highlight.detailsEn
        : widget.highlight.detailsMs;
    final String appBarTitle = isEnglish ? 'STEM Highlights' : 'Sorotan STEM';

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
                    Expanded(
                      child: Text(
                        appBarTitle,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: textColor,
                        ),
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
                    child: SingleChildScrollView(
                      controller: _scrollController,

                      padding: const EdgeInsets.fromLTRB(28, 13, 18, 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            displayTitle,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 10),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: cardBg,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: isDark ? [] : appBoxShadow,
                              border: isDark
                                  ? Border.all(color: Colors.white10)
                                  : null,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(widget.highlight.image),
                                  ),
                                ),
                                const SizedBox(height: 12),

                                Text(
                                  displaySubtitle,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                                Divider(
                                  height: 15,
                                  thickness: 1,
                                  color: isDark
                                      ? Colors.white24
                                      : Colors.grey.shade300,
                                ),

                                ...displayDetails.map((item) {
                                  if (item.contains('assets/')) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10.0,
                                      ),
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          child: Image.asset(item),
                                        ),
                                      ),
                                    );
                                  }

                                  if (item.contains('Source:') ||
                                      item.contains('Sumber:')) {
                                    final bool isEn = item.contains('Source:');
                                    final String label = isEn
                                        ? "Source:"
                                        : "Sumber:";

                                    String body = item
                                        .replaceFirst(label, '')
                                        .trim();

                                    final RegExp urlRegExp = RegExp(
                                      r'(https?://[^\s]+)',
                                    );
                                    final Match? match = urlRegExp.firstMatch(
                                      body,
                                    );

                                    String citationText = body;
                                    String urlText = "";

                                    if (match != null) {
                                      citationText = body
                                          .substring(0, match.start)
                                          .trim();
                                      urlText = match.group(0) ?? "";
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: subTextColor,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: "$label\n",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),

                                              TextSpan(
                                                text: "$citationText\n",
                                                style: const TextStyle(
                                                  height: 1.4,
                                                ),
                                              ),

                                              if (urlText.isNotEmpty)
                                                TextSpan(
                                                  text: urlText,
                                                  style: TextStyle(
                                                    color: isDark
                                                        ? Colors.lightBlueAccent
                                                        : Colors.blueAccent,
                                                    height: 1.5,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  final String trimmedItem = item.trim();
                                  bool isHeading =
                                      trimmedItem.length < 40 &&
                                      !trimmedItem.endsWith('.');

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      isHeading
                                          ? trimmedItem
                                          : '• $trimmedItem',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: isHeading
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        height: 1.4,
                                        color: subTextColor,
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),

                          const SizedBox(height: 2),
                        ],
                      ),
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
