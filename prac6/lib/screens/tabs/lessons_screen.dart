import 'package:flutter/material.dart';
import '../../models/lesson.dart';
import '../../theme/app_theme.dart';
import '../../widgets/category_card.dart';
import '../../widgets/progress_card.dart';
import '../lesson_detail_screen.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress section
          const ProgressCard(
            completedLessons: 12,
            totalLessons: 30,
            streakDays: 5,
          ),
          
          const SizedBox(height: 30),
          
          // Categories section
          Text(
            'Learning Categories',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          
          const SizedBox(height: 15),
          
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 0.85,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: [
              CategoryCard(
                title: 'Numbers',
                description: 'Learn to count from 1 to 10',
                icon: Icons.looks_one_rounded,
                color: AppTheme.categoryColors[0],
                progress: 0.8,
                onTap: () => _navigateToLessonDetail(context, LessonType.numbers),
              ),
              CategoryCard(
                title: 'Alphabets',
                description: 'Learn A to Z letters',
                icon: Icons.text_fields_rounded,
                color: AppTheme.categoryColors[1],
                progress: 0.6,
                onTap: () => _navigateToLessonDetail(context, LessonType.alphabets),
              ),
              CategoryCard(
                title: 'Hindi',
                description: 'Learn Hindi alphabets',
                icon: Icons.language_rounded,
                color: AppTheme.categoryColors[3],
                progress: 0.3,
                onTap: () => _navigateToLessonDetail(context, LessonType.hindi),
              ),
              CategoryCard(
                title: 'Counting',
                description: 'Count objects and learn numbers',
                icon: Icons.calculate_rounded,
                color: AppTheme.categoryColors[2],
                progress: 0.4,
                onTap: () => _navigateToLessonDetail(context, LessonType.counting),
              ),
              CategoryCard(
                title: 'Spelling',
                description: 'Learn to spell simple words',
                icon: Icons.spellcheck_rounded,
                color: Colors.teal,
                progress: 0.2,
                onTap: () => _navigateToLessonDetail(context, LessonType.spelling),
              ),
            ],
          ),
          
          const SizedBox(height: 30)
        ],
      ),
    );
  }

  Widget _buildRecentLessonCard(
    BuildContext context,
    String title,
    String description,
    String symbol,
    Color color,
    double progress,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Symbol container
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  symbol,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ),
            
            const SizedBox(width: 15),
            
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  // Progress bar
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    borderRadius: BorderRadius.circular(10),
                    minHeight: 6,
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 10),
            
            // Continue button
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToLessonDetail(BuildContext context, LessonType type, {int lessonIndex = 0}) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => LessonDetailScreen(
          lessonType: type,
          initialIndex: lessonIndex,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;
          
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}

