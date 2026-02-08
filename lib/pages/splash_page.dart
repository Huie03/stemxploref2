// lib/pages/splash_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_screen.dart';
import 'package:stemxploref2/widgets/gradient_background.dart';

class SplashPage extends StatelessWidget {
  static const routeName = 'splash-page';
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pushReplacementNamed(context, MainScreen.routeName);
            },
            child: const Center(child: Logo()),
          ),
        ),
      ),
    );
  }
}

class Logo extends StatefulWidget {
  const Logo({super.key});

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    // 1. Initialize the controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // 2. Create a "Tween" for a gentle scaling effect (pulse)
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // 3. Make it loop back and forth
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose(); // Important: clean up memory
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String assetPath = 'assets/images/Logo_F2_2.png';

    return SizedBox.expand(
      child: Stack(
        children: [
          // ANIMATED Logo Position
          Positioned(
            left: 0,
            top: 190,
            right: 0,
            child: ScaleTransition(
              scale: _pulseAnimation, // This makes the logo pulse
              child: Image.asset(
                assetPath,
                width: 270,
                height: 270,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Main Tagline
          Positioned(
            left: 0,
            top: 475,
            right: 0,
            child: Text(
              'Inspiring young minds through STEM exploration',
              style: GoogleFonts.alice(
                textStyle: const TextStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Use this inside your Stack
          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.9, end: 1.2).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.elasticIn, // Makes it look "snappy"
                ),
              ),
              child: const Icon(
                Icons.touch_app,
                size: 40,
                color: Color.fromARGB(255, 255, 166, 0),
              ),
            ),
          ),

          // Bottom Instruction Text
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Text(
              'Touch to start',
              style: GoogleFonts.alice(
                textStyle: const TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(136, 0, 0, 0),
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
