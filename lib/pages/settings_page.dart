import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:stemxploref2/widgets/solid_background.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings';
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FlutterLocalization _localization = FlutterLocalization.instance;
  bool _isDarkMode = false; // Local state for the theme toggle

  @override
  void initState() {
    super.initState();
    // Add this listener
    FlutterLocalization.instance.onTranslatedLanguage = _onLanguageChanged;
  }

  // This function will be called whenever translate() is called anywhere in the app
  void _onLanguageChanged(Locale? locale) {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sync with the global language state
    final bool isEnglish = _localization.currentLocale?.languageCode == 'en';
    final String title = isEnglish ? 'Settings' : 'Tetapan';

    return Scaffold(
      body: SolidBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Consistent AppBar and Flag Toggle
              _buildCustomAppBar(title, isEnglish),

              const SizedBox(height: 20),

              // 2. Theme Mode Toggle (Replaces Language)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Icon(
                    _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: Colors.black,
                  ),
                  title: Text(
                    isEnglish ? "Theme Mode" : "Mod Tema",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    isEnglish
                        ? (_isDarkMode ? "Dark Mode" : "Light Mode")
                        : (_isDarkMode ? "Mod Gelap" : "Mod Terang"),
                  ),
                  trailing: Switch(
                    value: _isDarkMode,
                    activeColor: Colors.orange,
                    onChanged: (value) {
                      setState(() {
                        _isDarkMode = value;
                        // Add your theme switching logic here if you have a ThemeProvider
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Optional: Add more settings items here
            ],
          ),
        ),
      ),
    );
  }

  // Consistent AppBar Logic used in FAQ and Bookmark pages
  Widget _buildCustomAppBar(String title, bool isEnglish) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 50), // Spacer to balance the layout
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
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
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
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
              // Updates the global language state
              _localization.translate(value);
              setState(() {});
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
