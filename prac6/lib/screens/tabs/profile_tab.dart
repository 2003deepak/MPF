import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for profile
    const name = 'Jagganath';
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
        'title': 'Counting Champion',
        'description': 'Complete 10 counting quizzes',
        'unlocked': false,
        'icon': '🧮',
      },
      {
        'title': 'Spelling Wizard',
        'description': 'Learn 20 new words',
        'unlocked': false,
        'icon': '✏️',
      },
      {
        'title': 'Learning Enthusiast',
        'description': 'Use the app for 7 days in a row',
        'unlocked': true,
        'icon': '🏆',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Text('👦', style: TextStyle(fontSize: 60)),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Age: $age',
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatCard(
                        'Points',
                        totalPoints.toString(),
                        Icons.star,
                      ),
                      _buildStatCard(
                        'Quizzes',
                        quizzesCompleted.toString(),
                        Icons.quiz,
                      ),
                      _buildStatCard(
                        'Lessons',
                        lessonsCompleted.toString(),
                        Icons.book,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Achievements',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ...achievements.map(
                    (achievement) => _buildAchievementCard(
                      achievement['title'] as String,
                      achievement['description'] as String,
                      achievement['unlocked'] as bool,
                      achievement['icon'] as String,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildSettingsCard('Sound', true),
                  _buildSettingsCard('Music', false),
                  _buildSettingsCard('Notifications', true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      width: 90,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.blue, size: 30),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(
    String title,
    String description,
    bool unlocked,
    String icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: unlocked ? Colors.blue[100] : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              icon,
              style: TextStyle(
                fontSize: 24,
                color: unlocked ? null : Colors.grey[500],
              ),
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: unlocked ? Colors.black : Colors.grey[500],
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            color: unlocked ? Colors.grey[700] : Colors.grey[500],
          ),
        ),
        trailing: Icon(
          unlocked ? Icons.check_circle : Icons.lock,
          color: unlocked ? Colors.green : Colors.grey[400],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(String title, bool value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SwitchListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        value: value,
        onChanged: (newValue) {},
        activeColor: Colors.blue,
      ),
    );
  }
}
