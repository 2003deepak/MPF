enum QuizType {
  numbers,
  alphabets,
  counting,
  spelling,
}

class QuizQuestion {
  final String question;
  final String imageOrText;
  final List<String> options;
  final int correctAnswerIndex;

  QuizQuestion({
    required this.question,
    required this.imageOrText,
    required this.options,
    required this.correctAnswerIndex,
  });
}

