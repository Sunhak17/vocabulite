import 'package:flutter/material.dart';
import 'Tier_articles_page.dart';
import '../flashcard/flashcard_list_page.dart';
import '../home_page.dart';
import '../quiz/quiz_home_page.dart';
import '../profile/profile_page.dart';
import '../welcome_page.dart';
import '../../../data/user_progress_repository.dart';

class TierPage extends StatefulWidget {
  final bool showBottomNav;

  const TierPage({super.key, this.showBottomNav = true});

  @override
  State<TierPage> createState() => _TierPageState();
}

class _TierPageState extends State<TierPage> {
  final List<Map<String, dynamic>> _Tiers = [
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
      backgroundColor: const Color(0xFFF8FAFC),
      drawer: widget.showBottomNav
          ? Drawer(
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
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Row(
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
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.home,
                            color: Color(0xFF1976D2),
                          ),
                          title: const Text('Home'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomePage(),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.article,
                            color: Color(0xFFD97706),
                          ),
                          title: const Text('Articles'),
                          selected: true,
                          onTap: () => Navigator.pop(context),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.quiz,
                            color: Color(0xFF1976D2),
                          ),
                          title: const Text('Quiz'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const QuizHomePage(),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.style,
                            color: Color(0xFF8B4513),
                          ),
                          title: const Text('Flashcards'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const FlashcardListPage(),
                              ),
                            );
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.person, color: Colors.grey),
                          title: const Text('Profile'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ProfilePage(),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout, color: Colors.red),
                          title: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.red),
                          ),
                          onTap: () async {
                            Navigator.pop(context);
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Logout'),
                                content: const Text(
                                  'Are you sure you want to logout? Your progress has been saved.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.red,
                                    ),
                                    child: const Text('Logout'),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true && context.mounted) {
                              await clearCurrentUser();
                              if (context.mounted) {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (_) => const SplashPage(),
                                  ),
                                  (route) => false,
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : null,
      body: Builder(
        builder: (BuildContext scaffoldContext) {
          return Column(
            children: [
              const SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (widget.showBottomNav)
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.menu_rounded,
                                    color: Color(0xFF3B82F6),
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    Scaffold.of(scaffoldContext).openDrawer();
                                  },
                                ),
                              )
                            else
                              const SizedBox(width: 48),
                            const Text(
                              'Articles',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.info_outline,
                                  color: Color(0xFF3B82F6),
                                  size: 24,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      title: Row(
                                        children: [
                                          Icon(
                                            Icons.lightbulb_outline,
                                            color: Color(0xFF3B82F6),
                                            size: 28,
                                          ),
                                          const SizedBox(width: 12),
                                          const Text(
                                            'How to Complete',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            _buildInstructionStep(
                                              '1',
                                              'Choose Your tier',
                                              'Select a tier that matches your English proficiency (A1-C2)',
                                            ),
                                            const SizedBox(height: 16),
                                            _buildInstructionStep(
                                              '2',
                                              'Read Articles',
                                              'Browse and read articles to learn new vocabulary in context',
                                            ),
                                            const SizedBox(height: 16),
                                            _buildInstructionStep(
                                              '3',
                                              'Learn New Words',
                                              'Tap on highlighted words to add them to your flashcards',
                                            ),
                                            const SizedBox(height: 16),
                                            _buildInstructionStep(
                                              '4',
                                              'Bookmark Favorites',
                                              'Save articles you like to review them later',
                                            ),
                                            const SizedBox(height: 16),
                                            _buildInstructionStep(
                                              '5',
                                              'Practice & Progress',
                                              'Take quizzes to test your knowledge and track your improvement',
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          style: TextButton.styleFrom(
                                            foregroundColor: Color(0xFF3B82F6),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 12,
                                            ),
                                          ),
                                          child: const Text(
                                            'Got it!',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Title Section
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(59, 130, 246, 0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.auto_stories_rounded,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Choose Your tier',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Select difficulty to start learning',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Tiers Grid
                        ...List.generate(_Tiers.length, (index) {
                          final lvl = _Tiers[index];
                          final TierCode = lvl['code'] as String;
                          const TierOrder = [
                            'A1',
                            'A2',
                            'B1',
                            'B2',
                            'C1',
                            'C2',
                          ];
                          final currentIndex = TierOrder.indexOf(TierCode);
                          final isUnlocked =
                              currentIndex == 0 ||
                              (currentIndex > 0 &&
                                  (currentUser?.completedTiers.contains(
                                        TierOrder[currentIndex - 1],
                                      ) ??
                                      false));
                          final isCompleted =
                              currentUser?.completedTiers.contains(TierCode) ??
                              false;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildTierCard(
                              context: scaffoldContext,
                              code: TierCode,
                              label: lvl['label'],
                              color: lvl['color'],
                              isUnlocked: isUnlocked,
                              isCompleted: isCompleted,
                              onTap: () {
                                if (isUnlocked) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          TierArticlesPage(tier: TierCode),
                                    ),
                                  ).then((_) => setState(() {}));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                        'Complete previous Tiers to unlock this tier',
                                      ),
                                      backgroundColor: const Color(0xFFEF4444),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: const EdgeInsets.all(16),
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                        }),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTierCard({
    required BuildContext context,
    required String code,
    required String label,
    required Color color,
    required bool isUnlocked,
    required bool isCompleted,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isUnlocked ? 1.0 : 0.6,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isCompleted
                  ? const Color(0xFF10B981)
                  : Colors.grey.shade200,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // tier Badge
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(
                    color.red,
                    color.green,
                    color.blue,
                    0.1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color.fromRGBO(
                      color.red,
                      color.green,
                      color.blue,
                      0.3,
                    ),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    code,
                    style: TextStyle(
                      color: color,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // tier Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isCompleted
                          ? 'Completed ✓'
                          : isUnlocked
                          ? 'Tap to explore'
                          : 'Locked',
                      style: TextStyle(
                        fontSize: 13,
                        color: isCompleted
                            ? const Color(0xFF10B981)
                            : Colors.grey[600],
                        fontWeight: isCompleted
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),

              // Status Icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? Color.fromRGBO(16, 185, 129, 0.1)
                      : isUnlocked
                      ? Color.fromRGBO(59, 130, 246, 0.1)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isCompleted
                      ? Icons.check_circle
                      : isUnlocked
                      ? Icons.arrow_forward_ios
                      : Icons.lock,
                  color: isCompleted
                      ? const Color(0xFF10B981)
                      : isUnlocked
                      ? const Color(0xFF3B82F6)
                      : Colors.grey.shade400,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildInstructionStep(
    String number,
    String title,
    String description,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFF3B82F6),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 4),
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
}
