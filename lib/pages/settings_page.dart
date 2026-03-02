import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart'; // <--- THIS WAS MISSING
import 'package:stemxploref2/theme_provider.dart';
import 'package:stemxploref2/widgets/gradient_background.dart';
import 'package:stemxploref2/widgets/language_toggle.dart';
import '../widgets/box_shadow.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings';
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {
    super.initState();
    localization.onTranslatedLanguage = (locale) {
      if (mounted) setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDark = themeProvider.isDarkMode;

    final bool isEnglish = localization.currentLocale?.languageCode == 'en';
    final String title = isEnglish ? 'Settings' : 'Tetapan';

    final Color cardBg = Theme.of(context).colorScheme.surface;
    final Color textColor = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCustomAppBar(title, isEnglish, textColor),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: appBoxShadow,
                ),
                child: ListTile(
                  leading: Icon(
                    isDark ? Icons.dark_mode : Icons.light_mode,
                    color: isDark ? Colors.orangeAccent : Colors.black,
                  ),
                  title: Text(
                    isEnglish ? "Theme Mode" : "Mod Tema",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  subtitle: Text(
                    isEnglish
                        ? (isDark ? "Dark Mode" : "Light Mode")
                        : (isDark ? "Mod Gelap" : "Mod Terang"),
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  trailing: Switch(
                    value: isDark,
                    activeColor: Colors.orange,
                    onChanged: (value) {
                      themeProvider.toggleTheme();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(String title, bool isEnglish, Color textColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
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
    );
  }
}
