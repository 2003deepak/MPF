import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/company_page.dart';
import 'pages/registration_page.dart';

void main() {
  runApp(const TPOApp());
}

class TPOApp extends StatelessWidget {
  const TPOApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TPO SPIT',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/register': (context) => RegistrationForm(), 
        '/profile': (context) => ProfilePage(), 
        '/company': (context) => const CompanyPage(),
      },
    );
  }
}
