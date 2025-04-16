import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_background.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    
    // Logo animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    
    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOut,
    );
    
    _bounceAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 0.9), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.5, 1.0),
    ));
    
    // Text animation
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _textAnimation = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    );
    
    // Start animations
    _logoController.forward();
    
    Timer(const Duration(milliseconds: 1000), () {
      _textController.forward();
    });

    // Navigate to home screen
    Timer(const Duration(milliseconds: 3500), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOutCubic;
            
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated background
          const AnimatedBackground(),
          
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo animation
                AnimatedBuilder(
                  animation: _logoController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _logoAnimation.value * _bounceAnimation.value,
                      child: child,
                    );
                  },
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Center(
                      child: ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: AppTheme.primaryGradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: const Icon(
                          Icons.school_rounded,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Text animation
                FadeTransition(
                  opacity: _textAnimation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.5),
                      end: Offset.zero,
                    ).animate(_textAnimation),
                    child: Column(
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: AppTheme.primaryGradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: const Text(
                            'Kids Learning',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Text(
                          'Adventure',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 50),
                
                // Loading animation
                FadeTransition(
                  opacity: _textAnimation,
                  child: Container(
                    width: 200,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 2500),
                      builder: (context, value, child) {
                        return FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: value,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: AppTheme.secondaryGradient,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

