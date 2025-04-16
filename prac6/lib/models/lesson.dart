import 'package:flutter/material.dart';

enum LessonType {
  numbers,
  alphabets,
  counting,
  spelling,
  hindi,
}

class LessonItem {
  final String title;
  final String description;
  final String? image;
  final Color color;
  final List<String> examples;

  LessonItem({
    required this.title,
    required this.description,
    this.image,
    required this.color,
    this.examples = const [],
  });
}

