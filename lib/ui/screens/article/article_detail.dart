import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../../models/article.dart';
import '../../../data/user_progress_repository.dart';
import '../../../data/vocabulary_repository.dart';
import '../../widgets/flashcard_list_selector.dart';
import '../quiz/quiz_question_page.dart';

class ArticleDetail extends StatefulWidget {
  final Article article;
  const ArticleDetail({super.key, required this.article});

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  String? selectedWord;
  String? selectedDefinition;

  Future<void> _showAddToFlashcardDialog() async {
    if (selectedWord == null) return;

    await addWordToFlashcardList(
      context: context,
      word: selectedWord!,
      articleTitle: widget.article.title,
    );

    if (currentUser != null && !currentUser!.learnedWords.contains(selectedWord!)) {
      currentUser!.learnWord(selectedWord!);
      await saveUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 40),
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
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Icon(Icons.waving_hand, color: Colors.white, size: 28),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Articles',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.info_outline, color: Colors.white),
                    onPressed: () => _showHowToCompleteDialog(context),
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
                                color: Color.fromRGBO(255, 255, 255, 0.2),
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
                                  ...(VocabularyRepository.getExamples(
                                              selectedWord!.toLowerCase()) ??
                                          [])
                                      .map(
                                        (example) => Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 4,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                '• ',
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                ),
                                              ),
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
                                        ),
                                      ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(
                                  Icons.style,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () async {
                                    await _showAddToFlashcardDialog();
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
                          _showQuizConfirmationDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B4513),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'Take Quiz',
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
        ),
    );
  }

  void _showQuizConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.quiz, color: Color(0xFF1976D2), size: 28),
              SizedBox(width: 12),
              Text(
                'Ready for Quiz?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1976D2),
                ),
              ),
            ],
          ),
          content: Text(
            'Have you finished reading the article?\nAre you ready to test your understanding?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); // Close dialog, stay on article
              },
              child: Text(
                'Not Ready',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext); // Close dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        QuizQuestionPage(articleId: widget.article.id),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1976D2),
                foregroundColor: Colors.white,
              ),
              child: Text("I'm Ready!"),
              
            ),
          ],
        );
      },
    );
  }

  void _showHowToCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Color(0xFFD97706), size: 28),
              SizedBox(width: 12),
              Text(
                'How to Complete',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1976D2),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Follow these steps to complete this article:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1976D2),
                  ),
                ),
                SizedBox(height: 16),
                _buildStep(
                  '1',
                  'Read the Article',
                  'Read the entire article carefully to understand the content.',
                  Icons.article,
                ),
                SizedBox(height: 12),
                _buildStep(
                  '2',
                  'Learn Vocabulary',
                  'Tap on highlighted words to see their definitions and examples.',
                  Icons.spellcheck,
                ),
                SizedBox(height: 12),
                _buildStep(
                  '3',
                  'Save Words',
                  'Add important words to your flashcard collection for later review.',
                  Icons.style,
                ),
                SizedBox(height: 12),
                _buildStep(
                  '4',
                  'Take the Quiz',
                  'Click "Take Quiz" button and score 70% or higher to complete the article and unlock the next tier.',
                  Icons.quiz,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1976D2),
              ),
              child: Text('Got it!'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStep(String number, String title, String description, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Color(0xFF1976D2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 18, color: Color(0xFFD97706)),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContentWithHighlights() {
    String content = widget.article.content;
    List<TextSpan> spans = [];

    List<String> words = content.split(' ');

    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      String cleanWord = word.toLowerCase().replaceAll(RegExp(r'[.,!?]'), '');

      if (VocabularyRepository.hasWord(cleanWord)) {
        Color highlightColor = VocabularyRepository.getHighlightColor(cleanWord);

        spans.add(
          TextSpan(
            text: word + (i < words.length - 1 ? ' ' : ''),
            style: TextStyle(
              backgroundColor: highlightColor,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                setState(() {
                  selectedWord =
                      cleanWord.substring(0, 1).toUpperCase() +
                      cleanWord.substring(1);
                  selectedDefinition =
                      VocabularyRepository.getDefinition(cleanWord) ?? '';
                });
              },
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: word + (i < words.length - 1 ? ' ' : ''),
            style: const TextStyle(color: Colors.black87),
          ),
        );
      }
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 16,
          height: 1.6,
          color: Colors.black87,
        ),
        children: spans,
      ),
    );
  }
}
