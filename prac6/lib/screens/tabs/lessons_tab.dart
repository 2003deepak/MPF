import 'package:flutter/material.dart';
import '../../models/lesson.dart';
import '../lesson_detail_screen.dart';

class LessonsTab extends StatelessWidget {
  const LessonsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose a Lesson:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                children: [
                  _buildLessonCard(
                    context,
                    'Numbers',
                    Icons.looks_one_outlined,
                    Colors.orange,
                    LessonType.numbers,
                  ),
                  _buildLessonCard(
                    context,
                    'Alphabets',
                    Icons.text_fields,
                    Colors.green,
                    LessonType.alphabets,
                  ),
                  _buildLessonCard(
                    context,
                    'Counting',
                    Icons.calculate,
                    Colors.purple,
                    LessonType.counting,
                  ),
                  _buildLessonCard(
                    context,
                    'Spelling',
                    Icons.spellcheck,
                    Colors.red,
                    LessonType.spelling,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonCard(BuildContext context, String title, IconData icon, Color color, LessonType type) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LessonDetailScreen(lessonType: type),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [color, color.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 60,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

