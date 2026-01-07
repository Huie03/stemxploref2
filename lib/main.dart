// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'l10n/languages.dart';
import '/navigation_provider.dart';

// Import all your pages
import 'pages/main_screen.dart';
import 'pages/splash_page.dart';
import 'pages/home_page.dart';
import 'stem_info/stem_info_page.dart';
import 'learning_materials/learning_materials_page.dart';
import 'quiz_game/quiz_game_page.dart';
import 'pages/stem_careers_page.dart';
import 'daily_challenge/daily_challenge_page.dart';
import 'pages/faq_page.dart';
import 'pages/bookmark_page.dart';
import 'pages/info_page.dart';
import 'pages/settings_page.dart';
import 'stem_highlights/highlight.dart';
import 'stem_highlights/highlight_detail_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterLocalization localization = FlutterLocalization.instance;
  await localization.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NavigationProvider())],
      child: const STEMXploreApp(),
    ),
  );
}

class STEMXploreApp extends StatefulWidget {
  const STEMXploreApp({super.key});

  @override
  State<STEMXploreApp> createState() => _STEMXploreAppState();
}

class _STEMXploreAppState extends State<STEMXploreApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {
    super.initState();
    // 1. Initialize the localization
    localization.init(mapLocales: LOCALES, initLanguageCode: 'en');

    // 2. The critical listener: This tells the Root App to rebuild
    // whenever the language is changed from ANY page (including Bookmark).
    localization.onTranslatedLanguage = (Locale? locale) {
      if (mounted) {
        setState(() {});
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 3. Explicitly set the locale so the UI knows it must refresh
      locale: localization.currentLocale,
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        scaffoldBackgroundColor: const Color(0xFFF7E7C3),
      ),
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (_) => const SplashPage(),
        MainScreen.routeName: (_) => MainScreen(),
        HomePage.routeName: (_) => const HomePage(),
        StemInfoPage.routeName: (_) => const StemInfoPage(),
        LearningMaterialPage.routeName: (_) => const LearningMaterialPage(),
        QuizGamePage.routeName: (_) => const QuizGamePage(),
        StemCareersPage.routeName: (_) => const StemCareersPage(),
        DailyChallengePage.routeName: (_) => const DailyChallengePage(),
        FaqPage.routeName: (_) => const FaqPage(),
        BookmarkPage.routeName: (_) => const BookmarkPage(),
        InfoPage.routeName: (_) => const InfoPage(),
        SettingsPage.routeName: (_) => SettingsPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == HighlightDetailPage.routeName) {
          final args = settings.arguments as Highlight;
          return MaterialPageRoute(
            builder: (context) => HighlightDetailPage(highlight: args),
          );
        }
        return null;
      },
    );
  }
}
