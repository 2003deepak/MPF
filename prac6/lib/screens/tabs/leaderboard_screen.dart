import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/character_avatar.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for leaderboard
    final leaderboardData = [
      {
        'name': 'Aarav',
        'score': 950,
        'character': CharacterType.fox,
        'badge': '🏆',
      },
      {
        'name': 'Ishita',
        'score': 920,
        'character': CharacterType.bear,
        'badge': '🥈',
      },
      {
        'name': 'Vihaan',
        'score': 880,
        'character': CharacterType.rabbit,
        'badge': '🥉',
      },
      {
        'name': 'Anaya',
        'score': 850,
        'character': CharacterType.owl,
        'badge': '',
      },
      {
        'name': 'Kabir',
        'score': 820,
        'character': CharacterType.penguin,
        'badge': '',
      },
      {
        'name': 'Myra',
        'score': 790,
        'character': CharacterType.fox,
        'badge': '',
      },
      {
        'name': 'Rohan',
        'score': 760,
        'character': CharacterType.bear,
        'badge': '',
      },
      {
        'name': 'Saanvi',
        'score': 730,
        'character': CharacterType.rabbit,
        'badge': '',
      },
      {
        'name': 'Advait',
        'score': 700,
        'character': CharacterType.owl,
        'badge': '',
      },
      {
        'name': 'Pari',
        'score': 670,
        'character': CharacterType.penguin,
        'badge': '',
      },
    ];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          
          const SizedBox(height: 20),

          // Leaderboard list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'All Time Rankings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 15),
                ...List.generate(leaderboardData.length - 3, (index) {
                  final rank = index + 4;
                  final data = leaderboardData[index + 3];

                  return _buildLeaderboardItem(
                    rank,
                    data['name'] as String,
                    data['score'] as int,
                    data['character'] as CharacterType,
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 30),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildPodiumItem(
    String name,
    int score,
    CharacterType character,
    int position,
    Color color,
    String badge,
  ) {
    final isFirst = position == 1;
    final podiumHeight = isFirst ? 100.0 : (position == 2 ? 70.0 : 50.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Badge
        if (badge.isNotEmpty) Text(badge, style: const TextStyle(fontSize: 30)),

        // Avatar
        Stack(
          children: [
            CharacterAvatar(size: isFirst ? 70 : 60, characterType: character),
            if (isFirst)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.star_rounded,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
          ],
        ),

        const SizedBox(height: 10),

        // Name
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: isFirst ? 16 : 14,
          ),
        ),

        // Score
        Text(
          score.toString(),
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),

        const SizedBox(height: 10),

        // Podium
        Container(
          width: isFirst ? 80 : 70,
          height: podiumHeight,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$position',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: position == 1 ? Colors.white : Colors.white70,
                fontSize: isFirst ? 24 : 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardItem(
    int rank,
    String name,
    int score,
    CharacterType character,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
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
          // Rank
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.scaffoldBackground,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$rank',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          const SizedBox(width: 15),

          // Avatar
          CharacterAvatar(size: 50, characterType: character),

          const SizedBox(width: 15),

          // Name and score
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Score: $score',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),

          const Spacer(),

          // Trend indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color:
                  rank % 2 == 0
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  rank % 2 == 0
                      ? Icons.arrow_upward_rounded
                      : Icons.arrow_downward_rounded,
                  color: rank % 2 == 0 ? Colors.green : Colors.red,
                  size: 14,
                ),
                const SizedBox(width: 3),
                Text(
                  '${rank % 3 + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: rank % 2 == 0 ? Colors.green : Colors.red,
                    fontSize: 12,
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
