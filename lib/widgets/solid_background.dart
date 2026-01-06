import 'package:flutter/material.dart';

class SolidBackground extends StatelessWidget {
  final Widget child;

  const SolidBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // Solid color
        color: Color.fromARGB(255, 255, 255, 224),
      ),
      child: child,
    );
  }
}
