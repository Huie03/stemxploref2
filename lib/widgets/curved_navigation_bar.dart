//curved navigation bar
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class AppCurvedNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppCurvedNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: currentIndex,
      height: 60,

      backgroundColor: Colors.white,

      color: const Color(0xFFF2C458),
      buttonBackgroundColor: const Color(0xFFF2C458), // Keeping as requested

      animationDuration: const Duration(milliseconds: 300),
      items: [
        const Icon(Icons.home, size: 30),
        const Icon(Icons.bookmark_border, size: 30),

        // Your Info Icon Container
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(color: Colors.black, width: 2.5),
          ),
          alignment: Alignment.center,
          child: const Text(
            'i',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontFamily: 'serif',
              color: Colors.black,
            ),
          ),
        ),

        const Icon(Icons.settings, size: 30),
      ],
      onTap: onTap,
    );
  }
}
