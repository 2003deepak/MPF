import 'package:flutter/material.dart';

class LeaderboardTab extends StatelessWidget {
  const LeaderboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for leaderboard
    final leaderboardData = [
      {'name': 'Emma', 'score': 950, 'avatar': '👧'},
      {'name': 'Noah', 'score': 920, 'avatar': '👦'},
      {'name': 'Olivia', 'score': 880, 'avatar': '👧'},
      {'name': 'Liam', 'score': 850, 'avatar': '👦'},
      {'name': 'Ava', 'score': 820, 'avatar': '👧'},
      {'name': 'William', 'score': 790, 'avatar': '👦'},
      {'name': 'Sophia', 'score': 760, 'avatar': '👧'},
      {'name': 'James', 'score': 730, 'avatar': '👦'},
      {'name': 'Isabella', 'score': 700, 'avatar': '👧'},
      {'name': 'Benjamin', 'score': 670, 'avatar': '👦'},
    ];

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'Top Learners',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: leaderboardData.length - 3,
              itemBuilder: (context, index) {
                final rank = index ;
                final data = leaderboardData[index ];
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$rank',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      data['name'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'Score: ${data['score']}',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    trailing: Text(
                      data['avatar'] as String,
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  
}

