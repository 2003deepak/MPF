import 'package:flutter/material.dart';
import 'pages/faculty_page.dart';
import 'pages/department_page.dart';
import 'pages/notification_page.dart';
import 'pages/webview_page.dart';
import 'pages/feedback_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const FacultyPage(),
      routes: {
        '/department': (context) => const DepartmentPage(),
        '/notifications': (context) => const NotificationPage(),
        '/webview': (context) => const WebViewPage(),
        '/feedback': (context) => const FeedbackPage(),
      },
    );
  }
}