import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_background.dart';
import '../widgets/animated_menu_item.dart';
import 'tabs/lessons_screen.dart';
import 'tabs/quiz_screen.dart';
import 'tabs/leaderboard_screen.dart';
import 'tabs/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final List<Map<String, dynamic>> _menuItems = [
    {
      'title': 'Lessons',
      'icon': Icons.book,
      'color': AppTheme.categoryColors[0],
    },
    {'title': 'Quiz', 'icon': Icons.quiz, 'color': AppTheme.categoryColors[1]},
    {
      'title': 'Leaders',
      'icon': Icons.emoji_events,
      'color': AppTheme.categoryColors[2],
    },
    {
      'title': 'Profile',
      'icon': Icons.person,
      'color': AppTheme.categoryColors[3],
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated background
          const AnimatedBackground(isHomeScreen: true),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // Header
                _buildHeader(),

                // Page content
                Expanded(
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: child,
                      );
                    },
                    child: PageView(
                      controller: _pageController,
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      children: const [
                        LessonsScreen(),
                        QuizScreen(),
                        LeaderboardScreen(),
                        ProfileScreen(),
                      ],
                    ),
                  ),
                ),

                // Bottom navigation
                _buildBottomNavigation(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
        
        const SizedBox(width: 15),

          // Welcome text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hello, Student!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Ready to learn something new?',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 80,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          _menuItems.length,
          (index) => AnimatedMenuItem(
            icon: _menuItems[index]['icon'],
            title: _menuItems[index]['title'],
            color: _menuItems[index]['color'],
            isSelected: _selectedIndex == index,
            onTap: () => _onItemTapped(index),
          ),
        ),
      ),
    );
  }
}
