import 'package:flutter/material.dart';

class SolidBackground extends StatelessWidget {
  final Widget child;

  const SolidBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // Light yellow
        color: Color(0xFFFFFFE0),
      ),
      child: child,
    );
  }
}
