import 'package:flutter/material.dart';
import 'home.dart';
import 'profile.dart';
import 'discount.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Color(0xFF262626),
          secondary: Color(0xFFFD501E),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF262626)),
          bodyMedium: TextStyle(color: Color(0xFF262626)),
          headlineLarge: TextStyle(
            color: Color(0xFF262626),
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Color(0xFFFD501E),
          elevation: 0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF262626),
          selectedItemColor: Color(0xFFFD501E),
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key}); // ✅ Best practice to add `super.key`

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    DiscountPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-commerce App'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // ✅ Explicitly set for 4+ items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.loyalty),
            label: 'Discount',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
      ),
    );
  }
}
