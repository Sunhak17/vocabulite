import 'package:flutter/material.dart';
import 'level_articles_page.dart';

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
      body: SafeArea(
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
      ),
    );
  }
}
