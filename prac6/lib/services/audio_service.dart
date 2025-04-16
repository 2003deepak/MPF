import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/lesson.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  final FlutterTts _tts = FlutterTts();

  factory AudioService() {
    return _instance;
  }

  AudioService._internal() {
    _initializeTTS();
  }

  void _initializeTTS() async {
    await _tts.setLanguage("en-US"); // Set language (modify if needed)
    await _tts.setPitch(1.0); // Normal pitch
    await _tts.setSpeechRate(0.5); // Adjust speed for better clarity
  }

  Future<void> playSound(
    BuildContext context,
    String character,
    LessonType type,
  ) async {
    String textToSpeak = _getTextToSpeak(character, type);

    if (textToSpeak.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No valid text to speak!'),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    try {
      await _tts.speak(textToSpeak);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Speaking: $textToSpeak'),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error in speech synthesis: $e'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  String _getTextToSpeak(String character, LessonType type) {
    switch (type) {
      case LessonType.numbers:
        return 'Number $character';
      case LessonType.alphabets:
        return 'Letter $character';
      case LessonType.hindi:
        return 'Hindi letter $character';
      case LessonType.counting:
        return 'Counting to $character';
      case LessonType.spelling:
        return 'Spelling of $character';
      default:
        return '';
    }
  }
}
