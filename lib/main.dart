// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stemxploref2/pages/main_screen.dart';
import 'pages/splash_page.dart';
import 'pages/home_page.dart';
import 'stem_highlights/highlight_detail_page.dart';
import 'stem_info/stem_info_page.dart';
import 'learning_materials/learning_materials_page.dart';
import 'quiz_game/quiz_game_page.dart';
import 'pages/stem_careers_page.dart';
import 'daily_challenge/daily_challenge_page.dart';
import 'pages/faq_page.dart';
import 'stem_highlights/highlight.dart';
import 'pages/bookmark_page.dart';
import 'pages/info_page.dart';
import 'pages/settings_page.dart';
import '/navigation_provider.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'l10n/languages.dart';

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
    localization.init(mapLocales: LOCALES, initLanguageCode: 'en');
    localization.onTranslatedLanguage = (_) => setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // flutter_localization setup
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFFF7E7C3),
      ),
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (_) => SplashPage(),
        MainScreen.routeName: (_) => MainScreen(),
        HomePage.routeName: (_) => HomePage(),
        StemInfoPage.routeName: (_) => StemInfoPage(),
        LearningMaterialPage.routeName: (_) => LearningMaterialPage(),
        QuizGamePage.routeName: (_) => QuizGamePage(),
        StemCareersPage.routeName: (_) => StemCareersPage(),
        DailyChallengePage.routeName: (_) => DailyChallengePage(),
        FaqPage.routeName: (_) => FaqPage(),
        BookmarkPage.routeName: (_) => BookmarkPage(),
        InfoPage.routeName: (_) => InfoPage(),
        SettingsPage.routeName: (_) => SettingsPage(),
      },

      onGenerateRoute: (settings) {
        if (settings.name == HighlightDetailPage.routeName) {
          final args = settings.arguments as Highlight;

          return MaterialPageRoute(
            builder: (context) {
              return HighlightDetailPage(highlight: args);
            },
          );
        }
        return null;
      },
    );
  }
}
