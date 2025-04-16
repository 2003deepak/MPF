import 'package:flutter/material.dart';
import '../models/lesson.dart';
import '../theme/app_theme.dart';
import '../services/audio_service.dart';

class LessonDetailScreen extends StatefulWidget {
  final LessonType lessonType;
  final int initialIndex;

  const LessonDetailScreen({
    super.key,
    required this.lessonType,
    this.initialIndex = 0,
  });

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late List<LessonItem> _lessonItems;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  int _currentPage = 0;
  bool _showConfetti = false;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialIndex;
    _pageController = PageController(initialPage: _currentPage);
    _lessonItems = getLessonItems(widget.lessonType);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 0.9), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 1),
    ]).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  List<LessonItem> getLessonItems(LessonType type) {
    switch (type) {
      case LessonType.numbers:
        return List.generate(
          10,
          (index) => LessonItem(
            title: '${index + 1}',
            description: 'This is the number ${index + 1}',
            image: null,
            color: AppTheme.categoryColors[0],
            examples: _getNumberExamples(index + 1),
          ),
        );
      case LessonType.alphabets:
        return List.generate(
          26,
          (index) => LessonItem(
            title: String.fromCharCode(65 + index),
            description:
                '${String.fromCharCode(65 + index)} is for ${_getWordForLetter(String.fromCharCode(65 + index))}',
            image: null,
            color: AppTheme.categoryColors[1],
            examples: _getAlphabetExamples(String.fromCharCode(65 + index)),
          ),
        );
      case LessonType.hindi:
        final hindiLetters = [
          'अ',
          'आ',
          'इ',
          'ई',
          'उ',
          'ऊ',
          'ए',
          'ऐ',
          'ओ',
          'औ',
          'क',
          'ख',
          'ग',
          'घ',
          'ङ',
          'च',
          'छ',
          'ज',
          'झ',
          'ञ',
          'ट',
          'ठ',
          'ड',
          'ढ',
          'ण',
          'त',
          'थ',
          'द',
          'ध',
          'न',
          'प',
          'फ',
          'ब',
          'भ',
          'म',
          'य',
          'र',
          'ल',
          'व',
          'श',
          'ष',
          'स',
          'ह',
        ];
        return List.generate(
          hindiLetters.length,
          (index) => LessonItem(
            title: hindiLetters[index],
            description:
                '${hindiLetters[index]} is for ${_getWordForHindiLetter(hindiLetters[index])}',
            image: null,
            color: AppTheme.categoryColors[3],
            examples: _getHindiExamples(hindiLetters[index]),
          ),
        );
      case LessonType.counting:
        return List.generate(
          10,
          (index) => LessonItem(
            title: 'Count ${index + 1}',
            description: 'Count ${index + 1} objects',
            image: null,
            color: AppTheme.categoryColors[2],
            examples: _getCountingExamples(index + 1),
          ),
        );
      case LessonType.spelling:
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
        return List.generate(
          words.length,
          (index) => LessonItem(
            title: words[index],
            description: 'Spell the word: ${words[index]}',
            image: null,
            color: AppTheme.categoryColors[3],
            examples: _getSpellingExamples(words[index]),
          ),
        );
      default:
        return [];
    }
  }

  List<String> _getNumberExamples(int number) {
    switch (number) {
      case 1:
        return ['1 apple', '1 ball', '1 cat'];
      case 2:
        return ['2 apples', '2 balls', '2 cats'];
      case 3:
        return ['3 apples', '3 balls', '3 cats'];
      default:
        return ['$number apples', '$number balls', '$number cats'];
    }
  }

  List<String> _getAlphabetExamples(String letter) {
    switch (letter) {
      case 'A':
        return ['Apple', 'Ant', 'Airplane'];
      case 'B':
        return ['Ball', 'Balloon', 'Butterfly'];
      case 'C':
        return ['Cat', 'Car', 'Cake'];
      default:
        return ['${_getWordForLetter(letter)}'];
    }
  }

  List<String> _getCountingExamples(int count) {
    final emoji = ['🍎', '🍌', '🍊', '🍇', '🍓', '🍒', '🍑', '🥝', '🍍', '🥭'];
    return [emoji.sublist(0, count).join(' ')];
  }

  List<String> _getSpellingExamples(String word) {
    return [word.split('').join(' - ')];
  }

  String _getWordForLetter(String letter) {
    final words = {
      'A': 'Apple',
      'B': 'Ball',
      'C': 'Cat',
      'D': 'Dog',
      'E': 'Elephant',
      'F': 'Fish',
      'G': 'Giraffe',
      'H': 'House',
      'I': 'Ice cream',
      'J': 'Jelly',
      'K': 'Kite',
      'L': 'Lion',
      'M': 'Monkey',
      'N': 'Nest',
      'O': 'Orange',
      'P': 'Penguin',
      'Q': 'Queen',
      'R': 'Rabbit',
      'S': 'Sun',
      'T': 'Tree',
      'U': 'Umbrella',
      'V': 'Van',
      'W': 'Whale',
      'X': 'X-ray',
      'Y': 'Yacht',
      'Z': 'Zebra',
    };
    return words[letter] ?? 'Unknown';
  }

  String _getWordForHindiLetter(String letter) {
    final words = {
      'अ': 'अनार (Pomegranate)',
      'आ': 'आम (Mango)',
      'इ': 'इमली (Tamarind)',
      'ई': 'ईख (Sugarcane)',
      'उ': 'उल्लू (Owl)',
      'ऊ': 'ऊन (Wool)',
      'ए': 'एक (One)',
      'ऐ': 'ऐनक (Glasses)',
      'ओ': 'ओखली (Mortar)',
      'औ': 'औरत (Woman)',
      'क': 'कमल (Lotus)',
      'ख': 'खरगोश (Rabbit)',
      'ग': 'गाय (Cow)',
      'घ': 'घर (House)',
      'ङ': 'ङ (Nasal sound)',
      'च': 'चाय (Tea)',
      'छ': 'छाता (Umbrella)',
      'ज': 'जहाज (Ship)',
      'झ': 'झंडा (Flag)',
      'ञ': 'ञ (Nasal sound)',
      'ट': 'टमाटर (Tomato)',
      'ठ': 'ठंडा (Cold)',
      'ड': 'डमरू (Damru)',
      'ढ': 'ढोल (Drum)',
      'ण': 'ण (Retroflex nasal)',
      'त': 'तितली (Butterfly)',
      'थ': 'थाली (Plate)',
      'द': 'दरवाजा (Door)',
      'ध': 'धनुष (Bow)',
      'न': 'नाव (Boat)',
      'प': 'पतंग (Kite)',
      'फ': 'फल (Fruit)',
      'ब': 'बंदर (Monkey)',
      'भ': 'भालू (Bear)',
      'म': 'मछली (Fish)',
      'य': 'यज्ञ (Ritual)',
      'र': 'रथ (Chariot)',
      'ल': 'लड्डू (Laddu)',
      'व': 'वन (Forest)',
      'श': 'शेर (Lion)',
      'ष': 'षटकोण (Hexagon)',
      'स': 'सेब (Apple)',
      'ह': 'हाथी (Elephant)',
    };
    return words[letter] ?? 'Unknown';
  }

  List<String> _getHindiExamples(String letter) {
    switch (letter) {
      case 'क':
        return ['कमल (Lotus)', 'कलम (Pen)', 'कबूतर (Pigeon)'];
      case 'ख':
        return ['खरगोश (Rabbit)', 'खिलौना (Toy)', 'खजूर (Date)'];
      case 'ग':
        return ['गाय (Cow)', 'गुलाब (Rose)', 'गेंद (Ball)'];
      case 'अ':
        return ['अनार (Pomegranate)', 'अंगूर (Grapes)', 'अनाज (Grain)'];
      case 'आ':
        return ['आम (Mango)', 'आलू (Potato)', 'आकाश (Sky)'];
      default:
        return [_getWordForHindiLetter(letter)];
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = '';
    switch (widget.lessonType) {
      case LessonType.numbers:
        title = 'Learn Numbers';
        break;
      case LessonType.alphabets:
        title = 'Learn Alphabets';
        break;
      case LessonType.hindi:
        title = 'Learn Hindi';
        break;
      case LessonType.counting:
        title = 'Learn Counting';
        break;
      case LessonType.spelling:
        title = 'Learn Spelling';
        break;
    }

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackground,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: _lessonItems[_currentPage].color,
        elevation: 0,
      ),
      body: Stack(
        children: [
          
          // Content
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _lessonItems.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final item = _lessonItems[index];
                      return _buildLessonPage(item);
                    },
                  ),
                ),

                // Navigation
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Previous button
                      if (_currentPage > 0)
                        _buildNavigationButton(
                          Icons.arrow_back_rounded,
                          'Previous',
                          () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                        )
                      else
                        const SizedBox(width: 120),

                      // Next button
                      if (_currentPage < _lessonItems.length - 1)
                        _buildNavigationButton(
                          Icons.arrow_forward_rounded,
                          'Next',
                          () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          isNext: true,
                        )
                      else
                        _buildNavigationButton(
                          Icons.check_rounded,
                          'Complete',
                          () {
                            setState(() {
                              _showConfetti = true;
                            });

                            Future.delayed(const Duration(seconds: 3), () {
                              if (mounted) {
                                Navigator.pop(context);
                              }
                            });
                          },
                          isNext: true,
                          isComplete: true,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonPage(LessonItem item) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Main content card
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
                // Main symbol
                GestureDetector(
                  onTap: () {
                    _animationController.reset();
                    _animationController.forward();
                    _playSound();
                  },
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Transform.rotate(
                          angle: _rotationAnimation.value,
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [item.color, item.color.withOpacity(0.7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: item.color.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 100,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Description
                Text(
                  item.description,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                // Listen button
                ElevatedButton.icon(
                  onPressed: () {
                    _animationController.reset();
                    _animationController.forward();
                    _playSound();
                  },
                  icon: const Icon(Icons.volume_up_rounded),
                  label: const Text('Listen'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: item.color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Examples section
          Text(
            'Examples',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: item.color,
            ),
          ),

          const SizedBox(height: 15),

          // Example cards
          ...item.examples.map(
            (example) => _buildExampleCard(example, item.color),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildExampleCard(String example, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
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
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(Icons.star_rounded, color: color, size: 20),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              example,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton(
    IconData icon,
    String label,
    VoidCallback onTap, {
    bool isNext = false,
    bool isComplete = false,
  }) {
    final color =
        isComplete ? AppTheme.successColor : _lessonItems[_currentPage].color;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            if (!isNext) Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isNext) ...[
              const SizedBox(width: 8),
              Icon(icon, color: Colors.white, size: 20),
            ],
          ],
        ),
      ),
    );
  }

  void _playSound() {
    // Use the AudioService to play the sound
    AudioService().playSound(
      context,
      _lessonItems[_currentPage].title,
      widget.lessonType,
    );

    // Animate the character
    _animationController.reset();
    _animationController.forward();
  }
}
