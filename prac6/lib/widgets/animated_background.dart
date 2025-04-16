import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AnimatedBackground extends StatelessWidget {
  final bool isHomeScreen;
  
  const AnimatedBackground({
    super.key,
    this.isHomeScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFF7F6FF),
            Color(0xFFEEECFF),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

