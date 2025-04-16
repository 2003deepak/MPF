import 'package:flutter/material.dart';

class AppTheme {
  // Primary colors
  static const Color primaryColor = Color(0xFF6A5AE0);
  static const Color secondaryColor = Color(0xFFFF8FA2);
  static const Color accentColor = Color(0xFFFFD465);
  
  // Background colors
  static const Color scaffoldBackground = Color(0xFFF7F6FF);
  static const Color cardBackground = Colors.white;
  
  // Text colors
  static const Color textPrimary = Color(0xFF3A3A3A);
  static const Color textSecondary = Color(0xFF6F6F6F);
  
  // Success/Error colors
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFFF5252);

  // Gradient colors
  static const List<Color> primaryGradient = [
    Color(0xFF6A5AE0),
    Color(0xFF9C8FFF),
  ];
  
  static const List<Color> secondaryGradient = [
    Color(0xFFFF8FA2),
    Color(0xFFFFB7C5),
  ];
  
  static const List<Color> accentGradient = [
    Color(0xFFFFD465),
    Color(0xFFFFE9A8),
  ];

  // Category colors
  static const List<Color> categoryColors = [
    Color(0xFFFF8FA2), // Pink
    Color(0xFF6A5AE0), // Purple
    Color(0xFFFFD465), // Yellow
    Color(0xFF5FD068), // Green
  ];

  // Theme data
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: scaffoldBackground,
    fontFamily: 'Nunito',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        color: textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: textPrimary,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    cardTheme: CardTheme(
      color: cardBackground,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
  );
}

