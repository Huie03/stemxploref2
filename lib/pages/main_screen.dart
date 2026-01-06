//main_screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/navigation_provider.dart';
import 'package:stemxploref2/widgets/curved_navigation_bar.dart';
import 'home_page.dart';
import 'bookmark_page.dart';
import 'info_page.dart';
import 'settings_page.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main';
  MainScreen({super.key});

  final List<Widget> _pages = [
    const HomePage(),
    const BookmarkPage(),
    const InfoPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,

      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: navProvider.currentIndex, children: _pages),
      ),

      bottomNavigationBar: AppCurvedNavBar(
        currentIndex: navProvider.currentIndex,
        onTap: (index) {
          navProvider.setIndex(index);
        },
      ),
    );
  }
}
