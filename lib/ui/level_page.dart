import 'package:flutter/material.dart';
import 'level_articles_page.dart';
import 'flashcard_list_page.dart';

class LevelPage extends StatelessWidget {
  const LevelPage({super.key});

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
            // Drawer Header
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
            // Menu Items
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LevelArticlesPage(level: lvl['code'] as String),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
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
                                    lvl['code'],
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
                            ],
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
          if (title == 'Challenges') {
            Navigator.pop(context);
          } else if (title == 'Flashcards') {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FlashcardListPage()),
            );
          }
        },
      ),
    );
  }
}
