import 'package:flutter/material.dart';
import 'level_articles_page.dart';
import 'flashcard_list_page.dart';
import 'home_page.dart';
import 'quiz_home_page.dart';
import 'favorites_page.dart';
import '../data/user_progress_repository.dart';

class LevelPage extends StatefulWidget {
  const LevelPage({super.key});

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  static final List<Map<String, dynamic>> _levels = [
    {'code': 'A1', 'label': 'Beginner', 'color': Color(0xFF9E9E9E)},
    {'code': 'A2', 'label': 'Elementary', 'color': Color(0xFFFFC107)},
    {'code': 'B1', 'label': 'Intermediate', 'color': Color(0xFFE53935)},
    {'code': 'B2', 'label': 'Upper Intermediate', 'color': Color(0xFF8E24AA)},
    {'code': 'C1', 'label': 'Advanced', 'color': Color(0xFF43A047)},
    {'code': 'C2', 'label': 'Proficiency', 'color': Color(0xFF5E35B1)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
      ),
      body: Builder(
        builder: (BuildContext scaffoldContext) {
          return SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              // App Title
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Menu icon on the left
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                        onPressed: () {
                          Scaffold.of(scaffoldContext).openDrawer();
                        },
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.book, color: Colors.white, size: 32),
                    const SizedBox(width: 8),
                    const Text(
                      'VocabuLite',
                      style: TextStyle(
                        color: Color(0xFFFFC107),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 60), // Balance the menu icon
                  ],
                ),
              ),
              
              // Button header
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xFFFF8F00),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Text(
                  'Choose Your English language Level',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Level buttons
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ListView.separated(
                    itemCount: _levels.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final lvl = _levels[index];
                      final levelCode = lvl['code'] as String;
                      final isUnlocked = UserProgressRepository.isLevelUnlocked(levelCode);
                      final isCompleted = UserProgressRepository.isLevelCompleted(levelCode);
                      
                      return GestureDetector(
                        onTap: () {
                          if (isUnlocked) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LevelArticlesPage(level: levelCode),
                              ),
                            ).then((_) => setState(() {})); // Refresh on return
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Complete previous levels to unlock this level'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: Opacity(
                          opacity: isUnlocked ? 1.0 : 0.5,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isCompleted ? const Color(0xFF43A047) : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    // Level code badge
                                    Container(
                                      width: 90,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: (lvl['color'] as Color),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          levelCode,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Level label
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Text(
                                          lvl['label'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Lock icon or completed icon
                                    Padding(
                                      padding: const EdgeInsets.only(right: 16.0),
                                      child: isCompleted
                                          ? const Icon(
                                              Icons.check_circle,
                                              color: Color(0xFF43A047),
                                              size: 28,
                                            )
                                          : !isUnlocked
                                              ? const Icon(
                                                  Icons.lock,
                                                  color: Colors.grey,
                                                  size: 28,
                                                )
                                              : const SizedBox.shrink(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              
              // Footer links
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('Help', style: TextStyle(color: Colors.white70)),
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Privacy Policy', style: TextStyle(color: Colors.white70)),
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Terms of Service', style: TextStyle(color: Colors.white70)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
          );
        },
      ),
    );
  }
}
