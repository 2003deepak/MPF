import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/character_avatar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for profile
    const name = 'Madhumangal';
    const age = 7;
    const totalPoints = 1250;
    const quizzesCompleted = 25;
    const lessonsCompleted = 40;

    final achievements = [
      {
        'title': 'Number Master',
        'description': 'Complete all number lessons',
        'unlocked': true,
        'icon': '🔢',
      },
      {
        'title': 'Alphabet Expert',
        'description': 'Score 100% on alphabet quiz',
        'unlocked': true,
        'icon': '🔤',
      },
      {
        'title': 'Hindi Learner',
        'description': 'Learn 10 Hindi letters',
        'unlocked': true,
        'icon': '🇮🇳',
      },
      {
        'title': 'Learning Enthusiast',
        'description': 'Use the app for 7 days in a row',
        'unlocked': true,
        'icon': '🏆',
      },
    ];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // Profile header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              
            ),
            child: Column(
              children: [
                // Avatar and edit button
                Stack(
                  children: [
                    const CharacterAvatar(
                      size: 100,
                      characterType: CharacterType.fox,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppTheme.secondaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // Name and age
                const Text(
                  name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const Text(
                  'Age: $age',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),

                const SizedBox(height: 20),

                // Stats
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem(
                        'Points',
                        totalPoints.toString(),
                        Icons.star_rounded,
                      ),
                      _buildStatItem(
                        'Quizzes',
                        quizzesCompleted.toString(),
                        Icons.quiz_rounded,
                      ),
                      _buildStatItem(
                        'Lessons',
                        lessonsCompleted.toString(),
                        Icons.book_rounded,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Achievements section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Achievements',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    
                  ],
                ),

                const SizedBox(height: 15),

                // Achievement cards
                ...achievements.map(
                  (achievement) => _buildAchievementCard(
                    achievement['title'] as String,
                    achievement['description'] as String,
                    achievement['unlocked'] as bool,
                    achievement['icon'] as String,
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.black, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildAchievementCard(
    String title,
    String description,
    bool unlocked,
    String icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color:
                  unlocked
                      ? AppTheme.accentColor.withOpacity(0.1)
                      : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                icon,
                style: TextStyle(
                  fontSize: 24,
                  color: unlocked ? null : Colors.grey[400],
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
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: unlocked ? Colors.black : Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: unlocked ? Colors.grey[600] : Colors.grey[400],
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
