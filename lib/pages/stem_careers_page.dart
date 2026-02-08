// pages/stem_careers_page.dart
import 'package:flutter/material.dart';
import 'package:stemxploref2/widgets/gradient_background.dart';
import 'package:provider/provider.dart';
import '/navigation_provider.dart';
import 'package:stemxploref2/widgets/curved_navigation_bar.dart';
import '/widgets/language_toggle.dart';

class StemCareersPage extends StatelessWidget {
  static const routeName = '/stem-careers';
  const StemCareersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                title: const Text(
                  'STEM Careers',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
