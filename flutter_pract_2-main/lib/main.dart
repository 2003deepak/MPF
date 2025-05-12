import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MovieReviewApp());
}

class MovieReviewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Review App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
