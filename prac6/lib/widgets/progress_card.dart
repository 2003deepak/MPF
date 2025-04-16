import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProgressCard extends StatelessWidget {
  final int completedLessons;
  final int totalLessons;
  final int streakDays;

  const ProgressCard({
    super.key,
    required this.completedLessons,
    required this.totalLessons,
    required this.streakDays,
  });

  @override
  Widget build(BuildContext context) {
    final progress = completedLessons / totalLessons;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppTheme.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Text(
                'Your Progress',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Progress bar
          Stack(
            children: [
              // Background
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // Progress
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: AppTheme.accentGradient,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.accentColor.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                ),
              ),

              // Percentage text
              Center(
                child: Text(
                  '${(progress * 100).toInt()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStat('Completed', '$completedLessons lessons'),
              _buildStat(
                'Remaining',
                '${totalLessons - completedLessons} lessons',
              ),
              _buildStat('Total', '$totalLessons lessons'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
