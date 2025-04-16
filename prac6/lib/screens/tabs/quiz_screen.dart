import 'package:flutter/material.dart';
import '../../models/quiz.dart';
import '../../theme/app_theme.dart';
import '../../widgets/animated_background.dart';
import 'dart:math';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  QuizType _selectedQuizType = QuizType.numbers;
  bool _quizStarted = false;
  late List<QuizQuestion> _questions;
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _answered = false;
  int? _selectedAnswerIndex;
  bool _quizCompleted = false;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background
        if (!_quizStarted) const AnimatedBackground(isHomeScreen: true),

        // Content
        _quizStarted ? _buildQuiz() : _buildQuizSelection(),
      ],
    );
  }

  Widget _buildQuizSelection() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // Quiz categories
          Text(
            'Choose a Quiz Category',
            style: Theme.of(context).textTheme.headlineMedium,
          ),

          const SizedBox(height: 15),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 0.85,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: [
              _buildQuizCard(
                'Numbers Quiz',
                'Test your number recognition skills',
                Icons.looks_one_rounded,
                AppTheme.categoryColors[0],
                QuizType.numbers,
              ),
              _buildQuizCard(
                'Alphabets Quiz',
                'Test your letter recognition skills',
                Icons.text_fields_rounded,
                AppTheme.categoryColors[1],
                QuizType.alphabets,
              ),
              _buildQuizCard(
                'Counting Quiz',
                'Count objects and select the right answer',
                Icons.calculate_rounded,
                AppTheme.categoryColors[2],
                QuizType.counting,
              ),
              _buildQuizCard(
                'Spelling Quiz',
                'Match words with pictures',
                Icons.spellcheck_rounded,
                AppTheme.categoryColors[3],
                QuizType.spelling,
              ),
            ],
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildQuizCard(
    String title,
    String description,
    IconData icon,
    Color color,
    QuizType type,
  ) {
    final isSelected = _selectedQuizType == type;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedQuizType = type;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color:
                  isSelected
                      ? color.withOpacity(0.3)
                      : Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 8),
              spreadRadius: isSelected ? 2 : 0,
            ),
          ],
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: color, size: 30),
            ),

            const SizedBox(height: 15),

            // Title
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            // Description
            Text(
              description,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const Spacer(),

            // Start button
            if (isSelected)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _startQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Start Quiz',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _startQuiz() {
    setState(() {
      _quizStarted = true;
      _currentQuestionIndex = 0;
      _score = 0;
      _answered = false;
      _selectedAnswerIndex = null;
      _quizCompleted = false;
      _questions = _generateQuestions(_selectedQuizType);
    });
  }

  List<QuizQuestion> _generateQuestions(QuizType type) {
    final random = Random();

    switch (type) {
      case QuizType.numbers:
        return List.generate(5, (index) {
          final correctNumber = random.nextInt(10) + 1;
          final options = [correctNumber];

          while (options.length < 4) {
            final option = random.nextInt(10) + 1;
            if (!options.contains(option)) {
              options.add(option);
            }
          }

          options.shuffle();

          return QuizQuestion(
            question: 'Which number is this?',
            imageOrText: '$correctNumber',
            options: options.map((e) => '$e').toList(),
            correctAnswerIndex: options.indexOf(correctNumber),
          );
        });

      case QuizType.alphabets:
        return List.generate(5, (index) {
          final correctLetterCode = random.nextInt(26) + 65;
          final correctLetter = String.fromCharCode(correctLetterCode);

          final options = [correctLetter];

          while (options.length < 4) {
            final optionCode = random.nextInt(26) + 65;
            final option = String.fromCharCode(optionCode);
            if (!options.contains(option)) {
              options.add(option);
            }
          }

          options.shuffle();

          return QuizQuestion(
            question: 'Which letter is this?',
            imageOrText: correctLetter,
            options: options,
            correctAnswerIndex: options.indexOf(correctLetter),
          );
        });

      case QuizType.counting:
        return List.generate(5, (index) {
          final correctCount = random.nextInt(5) + 1;
          final options = [correctCount];

          while (options.length < 4) {
            final option = random.nextInt(5) + 1;
            if (!options.contains(option)) {
              options.add(option);
            }
          }

          options.shuffle();

          final emoji = [
            '🍎',
            '🍌',
            '🍊',
            '🍇',
            '🍓',
            '🍒',
            '🍑',
            '🥝',
            '🍍',
            '🥭',
          ];
          final randomEmoji = emoji[random.nextInt(emoji.length)];

          return QuizQuestion(
            question: 'How many ${randomEmoji}s are there?',
            imageOrText: List.generate(
              correctCount,
              (i) => randomEmoji,
            ).join(' '),
            options: options.map((e) => '$e').toList(),
            correctAnswerIndex: options.indexOf(correctCount),
          );
        });

      case QuizType.spelling:
        final words = [
          'CAT',
          'DOG',
          'SUN',
          'BALL',
          'TREE',
          'FISH',
          'BIRD',
          'STAR',
          'MOON',
          'BOOK',
        ];
        final emojis = [
          '🐱',
          '🐶',
          '☀️',
          '⚽',
          '🌳',
          '🐠',
          '🐦',
          '⭐',
          '🌙',
          '📚',
        ];

        final selectedIndices = List<int>.generate(words.length, (i) => i)
          ..shuffle();
        selectedIndices.length = 5;

        return List.generate(5, (index) {
          final wordIndex = selectedIndices[index];
          final correctWord = words[wordIndex];
          final emoji = emojis[wordIndex];

          final options = [correctWord];

          while (options.length < 4) {
            final option = words[random.nextInt(words.length)];
            if (!options.contains(option)) {
              options.add(option);
            }
          }

          options.shuffle();

          return QuizQuestion(
            question: 'Which word matches this picture?',
            imageOrText: emoji,
            options: options,
            correctAnswerIndex: options.indexOf(correctWord),
          );
        });
    }
  }

  Widget _buildQuiz() {
    if (_quizCompleted) {
      return _buildQuizResults();
    }

    final currentQuestion = _questions[_currentQuestionIndex];
    final color = AppTheme.categoryColors[_selectedQuizType.index];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _quizStarted = false;
                  });
                },
                icon: const Icon(Icons.arrow_back_rounded),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: color,
                  padding: const EdgeInsets.all(12),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question ${_currentQuestionIndex + 1}/${_questions.length}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    LinearProgressIndicator(
                      value: (_currentQuestionIndex + 1) / _questions.length,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      borderRadius: BorderRadius.circular(10),
                      minHeight: 6,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star_rounded, color: color, size: 20),
                    const SizedBox(width: 5),
                    Text(
                      '$_score',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Question
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  currentQuestion.question,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      currentQuestion.imageOrText,
                      style: const TextStyle(fontSize: 80),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Options
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                currentQuestion.options.length,
                (index) => _buildOptionCard(index, currentQuestion, color),
              ),
            ),
          ),

          // Next button
          if (_answered)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  _currentQuestionIndex < _questions.length - 1
                      ? 'Next Question'
                      : 'See Results',
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(int index, QuizQuestion question, Color color) {
    final isCorrect = index == question.correctAnswerIndex;
    final isSelected = _selectedAnswerIndex == index;

    Color backgroundColor = Colors.white;
    Color borderColor = Colors.transparent;
    Color textColor = Colors.black;

    if (_answered) {
      if (isCorrect) {
        backgroundColor = Colors.green.withOpacity(0.1);
        borderColor = Colors.green;
        textColor = Colors.green;
      } else if (isSelected) {
        backgroundColor = Colors.red.withOpacity(0.1);
        borderColor = Colors.red;
        textColor = Colors.red;
      }
    } else if (isSelected) {
      backgroundColor = color.withOpacity(0.1);
      borderColor = color;
      textColor = color;
    }

    return GestureDetector(
      onTap: _answered ? null : () => _selectAnswer(index),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale:
                isSelected && _animationController.isAnimating
                    ? _scaleAnimation.value
                    : 1.0,
            child: child,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              question.options[index],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  void _selectAnswer(int index) {
    _animationController.reset();
    _animationController.forward();

    setState(() {
      _selectedAnswerIndex = index;
      _answered = true;

      if (index == _questions[_currentQuestionIndex].correctAnswerIndex) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _answered = false;
        _selectedAnswerIndex = null;
      });
    } else {
      setState(() {
        _quizCompleted = true;
      });
    }
  }

  Widget _buildQuizResults() {
    final percentage = (_score / _questions.length) * 100;
    final color = AppTheme.categoryColors[_selectedQuizType.index];

    String message;
    IconData icon;

    if (percentage >= 80) {
      message = 'Excellent job!';
      icon = Icons.emoji_events_rounded;
    } else if (percentage >= 60) {
      message = 'Good work!';
      icon = Icons.thumb_up_rounded;
    } else {
      message = 'Keep practicing!';
      icon = Icons.favorite_rounded;
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _quizStarted = false;
                  });
                },
                icon: const Icon(Icons.arrow_back_rounded),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: color,
                  padding: const EdgeInsets.all(12),
                ),
              ),
              const SizedBox(width: 15),
              const Text(
                'Quiz Results',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const Spacer(),

          // Results card
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                // Icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 60),
                ),

                const SizedBox(height: 30),

                // Score
                Text(
                  '$_score/${_questions.length}',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),

                const SizedBox(height: 10),

                // Percentage
                Text(
                  '${percentage.toInt()}%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // Message
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'You\'ve completed the quiz!',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          const Spacer(),

        ],
      ),
    );
  }
}
