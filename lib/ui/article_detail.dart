import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../model/article.dart';
import '../model/flashcard.dart';
import '../data/flashcard_repository.dart';
import 'flashcard_list_page.dart';

class ArticleDetail extends StatefulWidget {
  final Article article;
  const ArticleDetail({super.key, required this.article});

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  String? selectedWord;
  String? selectedDefinition;

  // Define vocabulary words and their definitions
  final Map<String, String> vocabulary = {
    'reading': '[verb] the action of reading books or other written material',
    'books': '[noun] a written or printed work consisting of pages',
    'adventure': '[noun] an unusual and exciting experience or activity',
    'exciting': '[adjective] causing great enthusiasm and eagerness',
    'improve': '[verb] make or become better',
    'hobby': '[noun] a regular activity done for enjoyment in free time',
    'painting': '[verb] the action or skill of using paint',
    'landscapes': '[noun] all the visible features of an area of land',
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
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
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
                            const SizedBox(height: 8),
                            Text(
                              'Example: My ${selectedWord!} is painting landscapes.',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white70,
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
                selectedDefinition = vocabulary[cleanWord];
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('🇬🇧', style: TextStyle(fontSize: 24)),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.emoji_events, color: Colors.orange, size: 20),
                                const SizedBox(width: 4),
                                const Text('0', style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.notifications, color: Colors.orange, size: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(context, 'Chat', Icons.chat_bubble_outline, false),
                _buildMenuItem(context, 'Personas', Icons.person_outline, false),
                _buildMenuItem(context, 'Flashcards', Icons.style_outlined, false),
                _buildMenuItem(context, 'Challenges', Icons.bolt, true),
                const Divider(height: 32),
                _buildMenuItem(context, 'Friends', Icons.people_outline, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFFE5CC) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? const Color(0xFFFF8F00) : Colors.grey.shade700,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFFFF8F00) : Colors.grey.shade800,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {
          if (title == 'Flashcards') {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FlashcardListPage()),
            );
          } else if (title == 'Challenges') {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
