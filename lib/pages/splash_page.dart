// lib/pages/splash_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_screen.dart';

class SplashPage extends StatelessWidget {
  static const routeName = 'splash-page';
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFE0),

      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque, // tap anywhere
          onTap: () {
            Navigator.pushReplacementNamed(context, MainScreen.routeName);
          },
          child: const Center(child: Logo()),
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    const String assetPath = 'assets/images/Logo_F2.png';

    return SizedBox.expand(
      child: Stack(
        children: [
          // Logo Position
          Positioned(
            left: 0,
            top: 200,
            right: 0,
            child: Image.asset(
              assetPath,
              width: 290,
              height: 290,
              fit: BoxFit.contain,
            ),
          ),

          // Main Tagline
          Positioned(
            left: 0,
            top: 480,
            right: 0,
            child: Text(
              'Inspiring young minds through STEM exploration',
              style: GoogleFonts.alice(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Hand Tap Icon
          const Positioned(
            left: 0,
            right: 0,
            bottom: 35,
            child: Icon(Icons.touch_app, size: 40, color: Colors.black45),
          ),

          // Bottom Instruction Text
          Positioned(
            left: 0,
            right: 0,
            bottom: 15,
            child: Text(
              'Touch to start',
              style: GoogleFonts.alice(
                textStyle: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
