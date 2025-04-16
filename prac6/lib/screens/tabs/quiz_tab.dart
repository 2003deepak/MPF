import 'package:flutter/material.dart';
import '../../models/quiz.dart';
import 'dart:math';

class QuizTab extends StatefulWidget {
  const QuizTab({super.key});

  @override
  State<QuizTab> createState() => _QuizTabState();
}

class _QuizTabState extends State<QuizTab> {
  QuizType _selectedQuizType = QuizType.numbers;
  bool _quizStarted = false;
  late List<QuizQuestion> _questions;
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _answered = false;
  int? _selectedAnswerIndex;
  bool _quizCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _quizStarted ? _buildQuiz() : _buildQuizSelection(),
      ),
    );
  }

  Widget _buildQuizSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose a Quiz:',
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
              _buildQuizCard(
                'Numbers Quiz',
                Icons.looks_one_outlined,
                Colors.orange,
                QuizType.numbers,
              ),
              _buildQuizCard(
                'Alphabets Quiz',
                Icons.text_fields,
                Colors.green,
                QuizType.alphabets,
              ),
              _buildQuizCard(
                'Counting Quiz',
                Icons.calculate,
                Colors.purple,
                QuizType.counting,
              ),
              _buildQuizCard(
                'Spelling Quiz',
                Icons.spellcheck,
                Colors.red,
                QuizType.spelling,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuizCard(String title, IconData icon, Color color, QuizType type) {
    final isSelected = _selectedQuizType == type;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedQuizType = type;
        });
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: isSelected ? 3 : 0,
          ),
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
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (isSelected) ...[
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: _startQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: color,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: const Text(
                    'Start Quiz',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ],
          ),
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
          
          return QuizQuestion(
            question: 'How many objects are there?',
            imageOrText: List.generate(correctCount, (i) => '🔵').join(' '),
            options: options.map((e) => '$e').toList(),
            correctAnswerIndex: options.indexOf(correctCount),
          );
        });
        
      case QuizType.spelling:
        final words = ['CAT', 'DOG', 'SUN', 'BALL', 'TREE', 'FISH', 'BIRD', 'STAR', 'MOON', 'BOOK'];
        final selectedWords = List<String>.from(words)..shuffle();
        selectedWords.length = 5;
        
        return List.generate(5, (index) {
          final correctWord = selectedWords[index];
          final options = [correctWord];
          
          while (options.length < 4) {
            final option = words[random.nextInt(words.length)];
            if (!options.contains(option)) {
              options.add(option);
            }
          }
          
          options.shuffle();
          
          return QuizQuestion(
            question: 'Which word matches the picture?',
            imageOrText: '${correctWord.toLowerCase()} image',
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
    
    return Column(
      children: [
        LinearProgressIndicator(
          value: (_currentQuestionIndex + 1) / _questions.length,
          backgroundColor: Colors.grey[300],
          color: Colors.blue,
          minHeight: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${_currentQuestionIndex + 1}/${_questions.length}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Score: $_score',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                const SizedBox(height: 20),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      currentQuestion.imageOrText,
                      style: const TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: currentQuestion.options.length,
            itemBuilder: (context, index) {
              final isCorrect = index == currentQuestion.correctAnswerIndex;
              final isSelected = _selectedAnswerIndex == index;
              
              Color? backgroundColor;
              if (_answered) {
                backgroundColor = isCorrect ? Colors.green[100] : (isSelected ? Colors.red[100] : null);
              } else {
                backgroundColor = isSelected ? Colors.blue[100] : null;
              }
              
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 10),
                color: backgroundColor,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(
                    currentQuestion.options[index],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: _answered ? null : () => _selectAnswer(index),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: isSelected ? Colors.blue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        if (_answered)
          ElevatedButton(
            onPressed: _nextQuestion,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            child: Text(
              _currentQuestionIndex < _questions.length - 1 ? 'Next Question' : 'See Results',
            ),
          ),
      ],
    );
  }

  void _selectAnswer(int index) {
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
    String message;
    Color messageColor;
    
    if (percentage >= 80) {
      message = 'Excellent job!';
      messageColor = Colors.green;
    } else if (percentage >= 60) {
      message = 'Good work!';
      messageColor = Colors.blue;
    } else {
      message = 'Keep practicing!';
      messageColor = Colors.orange;
    }
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Quiz Results',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$_score/${_questions.length}',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: messageColor,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _quizStarted = false;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            child: const Text('Try Another Quiz'),
          ),
        ],
      ),
    );
  }
}

