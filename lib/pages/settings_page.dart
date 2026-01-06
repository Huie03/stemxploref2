//settings_page
import 'package:flutter/material.dart';
import 'package:stemxploref2/widgets/solid_background.dart';
import 'language_screen.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SolidBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  isEnglish ? 'Settings' : 'Tetapan',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: ListTile(
                  leading: const Icon(Icons.language, color: Colors.black),
                  title: Text(isEnglish ? "Language" : "Bahasa"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () async {
                    // Navigate and get updated language
                    final selectedLanguage = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LanguageScreen()),
                    );
                    if (selectedLanguage != null && selectedLanguage is bool) {
                      setState(() {
                        isEnglish = selectedLanguage;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
