import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../model/article.dart';
import '../model/flashcard.dart';
import '../data/flashcard_repository.dart';
import 'flashcard_list_page.dart';
import 'home_page.dart';
import 'level_page.dart';
import 'quiz_home_page.dart';
import 'comprehension_quiz_page.dart';
import 'favorites_page.dart';

class ArticleDetail extends StatefulWidget {
  final Article article;
  const ArticleDetail({super.key, required this.article});

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  String? selectedWord;
  String? selectedDefinition;

  // Define vocabulary words and their definitions with examples
  final Map<String, Map<String, dynamic>> vocabulary = {
    'reading': {
      'definition': '[verb] the action of reading books or other written material',
      'examples': [
        'I enjoy reading before bed every night.',
        'Reading helps improve your vocabulary and imagination.',
      ]
    },
    'books': {
      'definition': '[noun] a written or printed work consisting of pages',
      'examples': [
        'The library has thousands of books on various topics.',
        'She borrowed three books from the bookstore.',
      ]
    },
    'adventure': {
      'definition': '[noun] an unusual and exciting experience or activity',
      'examples': [
        'Their trip to the mountains was a great adventure.',
        'He loves stories about adventure and exploration.',
      ]
    },
    'exciting': {
      'definition': '[adjective] causing great enthusiasm and eagerness',
      'examples': [
        'The football match was very exciting to watch.',
        'Starting a new job can be exciting and challenging.',
      ]
    },
    'improve': {
      'definition': '[verb] make or become better',
      'examples': [
        'Practice will help you improve your skills.',
        'The weather is starting to improve.',
      ]
    },
    'hobby': {
      'definition': '[noun] a regular activity done for enjoyment in free time',
      'examples': [
        'Photography is my favorite hobby.',
        'What hobbies do you have?',
      ]
    },
    'painting': {
      'definition': '[verb] the action or skill of using paint',
      'examples': [
        'She spends her weekends painting landscapes.',
        'Painting requires patience and creativity.',
      ]
    },
    'landscapes': {
      'definition': '[noun] all the visible features of an area of land',
      'examples': [
        'The artist is famous for painting beautiful landscapes.',
        'Mountain landscapes are breathtaking in autumn.',
      ]
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: _buildDrawer(context),
      body: Builder(
        builder: (BuildContext scaffoldContext) {
          return SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () => Scaffold.of(scaffoldContext).openDrawer(),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.waving_hand, color: Colors.white, size: 28),
                  const SizedBox(width: 8),
                  const Text(
                    'Welcome!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      widget.article.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD97706),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Content with highlighted words
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF9E6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: _buildContentWithHighlights(),
                    ),

                    // Definition card (if word is selected)
                    if (selectedWord != null && selectedDefinition != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD97706),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedWord!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              selectedDefinition!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Example sentences
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Examples:',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  ...((vocabulary[selectedWord!.toLowerCase()]?['examples'] as List<String>?) ?? []).map((example) => Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('• ', style: TextStyle(color: Colors.white70)),
                                        Expanded(
                                          child: Text(
                                            example,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(Icons.style, color: Colors.white, size: 20),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    // Save to flashcard repository
                                    FlashcardRepository.add(
                                      Flashcard(
                                        word: selectedWord!,
                                        definition: selectedDefinition!,
                                        example: 'Example: My ${selectedWord!.toLowerCase()} is painting landscapes.',
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Added "$selectedWord" to Flashcard'),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Add to Flashcard',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Start Quiz Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Starting quiz...')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B4513),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 3,
                        ),
                        child: const Text(
                          'Start Quiz',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),          );
        },      ),
    );
  }

  Widget _buildContentWithHighlights() {
    String content = widget.article.content;
    List<TextSpan> spans = [];
    
    // Split content by spaces
    List<String> words = content.split(' ');
    
    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      String cleanWord = word.toLowerCase().replaceAll(RegExp(r'[.,!?]'), '');
      
      if (vocabulary.containsKey(cleanWord)) {
        // Highlighted word
        Color highlightColor;
        switch (cleanWord) {
          case 'adventure':
            highlightColor = const Color(0xFFB3D9FF);
            break;
          case 'exciting':
            highlightColor = const Color(0xFFFFB3B3);
            break;
          case 'improve':
            highlightColor = const Color(0xFFB3FFB3);
            break;
          default:
            highlightColor = const Color(0xFFFFE5B3);
        }
        
        spans.add(TextSpan(
          text: word + (i < words.length - 1 ? ' ' : ''),
          style: TextStyle(
            backgroundColor: highlightColor,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              setState(() {
                selectedWord = cleanWord.substring(0, 1).toUpperCase() + cleanWord.substring(1);
                selectedDefinition = vocabulary[cleanWord]?['definition'] ?? '';
              });
            },
        ));
      } else {
        // Regular word
        spans.add(TextSpan(
          text: word + (i < words.length - 1 ? ' ' : ''),
          style: const TextStyle(color: Colors.black87),
        ));
      }
    }
    
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
        children: spans,
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.home, color: Color(0xFF1976D2)),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.article, color: Color(0xFFD97706)),
                  title: const Text('Articles'),
                  selected: true,
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.bookmark, color: Color(0xFFE91E63)),
                  title: const Text('Favorites'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FavoritesPage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.quiz, color: Color(0xFF1976D2)),
                  title: const Text('Quiz'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const QuizHomePage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.style, color: Color(0xFF8B4513)),
                  title: const Text('Flashcards'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FlashcardListPage()),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.grey),
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile coming soon!')),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
