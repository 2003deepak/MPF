import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum CharacterType {
  fox,
  bear,
  rabbit,
  owl,
  penguin,
}

class CharacterAvatar extends StatelessWidget {
  final double size;
  final CharacterType characterType;
  final bool withBackground;

  const CharacterAvatar({
    super.key,
    required this.size,
    this.characterType = CharacterType.fox,
    this.withBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: withBackground ? Colors.white : Colors.transparent,
        shape: BoxShape.circle,
        boxShadow: withBackground
            ? [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ]
            : null,
      ),
      child: Center(
        child: Text(
          _getCharacterEmoji(),
          style: TextStyle(
            fontSize: size * 0.6,
          ),
        ),
      ),
    );
  }

  String _getCharacterEmoji() {
    switch (characterType) {
      case CharacterType.fox:
        return '🦊';
      case CharacterType.bear:
        return '🐻';
      case CharacterType.rabbit:
        return '🐰';
      case CharacterType.owl:
        return '🦉';
      case CharacterType.penguin:
        return '🐧';
    }
  }
}
