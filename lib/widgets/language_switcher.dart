import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../navigation_provider.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);
    final isEnglish = navProvider.locale.languageCode == 'en';

    return GestureDetector(
      onTap: () {
        navProvider.setLocale(
          isEnglish ? const Locale('ms') : const Locale('en'),
        );
      },
      child: CircleAvatar(
        backgroundImage: AssetImage(
          isEnglish
              ? 'assets/flag/language us_flag.png'
              : 'assets/flag/language ms_flag.png',
        ),
      ),
    );
  }
}
