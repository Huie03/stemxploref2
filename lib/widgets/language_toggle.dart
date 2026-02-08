import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class LanguageToggle extends StatefulWidget {
  // Add this line
  final VoidCallback? onLanguageChanged;

  const LanguageToggle({super.key, this.onLanguageChanged});

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final bool isEnglish =
        localization.currentLocale?.languageCode == 'en' ||
        localization.currentLocale == null;

    return GestureDetector(
      onTap: () {
        final String nextLocale = isEnglish ? 'ms' : 'en';
        localization.translate(nextLocale);

        // 1. Refresh the flag itself
        setState(() {});

        // 2. Refresh the parent page
        if (widget.onLanguageChanged != null) {
          widget.onLanguageChanged!();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              key: ValueKey<String>(isEnglish ? 'en' : 'ms'),
              isEnglish
                  ? 'assets/flag/language us_flag.png'
                  : 'assets/flag/language ms_flag.png',
              width: 36,
              height: 36,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
