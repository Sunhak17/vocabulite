import 'package:flutter/material.dart';
import 'dart:async';
import 'article/Tier_page.dart';
import 'flashcard/flashcard_list_page.dart';
import 'quiz/quiz_home_page.dart';
import 'profile/profile_page.dart';
import '../../data/user_progress_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PageController _pageController;
  int _currentFeaturePage = 0;
  Timer? _autoSlideTimer;

  final GlobalKey<_RefreshablePageState> _articlesKey = GlobalKey();
  final GlobalKey<_RefreshablePageState> _flashcardsKey = GlobalKey();
  final GlobalKey<_RefreshablePageState> _profileKey = GlobalKey();

  final List<Map<String, dynamic>> _appFeatures = [
    {
      'title': 'Learn Vocabulary',
      'description': 'Master new words with interactive flashcards and spaced repetition.',
      'image': 'assets/images/s1.png',
      'color': const Color(0xFF3B82F6),
    },
    {
      'title': 'Read Articles',
      'description': 'Improve reading skills with articles across 6 CEFR levels.',
      'image': 'assets/images/s2.png',
      'color': const Color(0xFF10B981),
    },
    {
      'title': 'Take Quizzes',
      'description': 'Test your knowledge and track progress with engaging quizzes.',
      'image': 'assets/images/s3.png',
      'color': const Color(0xFFF59E0B),
    },
    {
      'title': 'Track Progress',
      'description': 'Monitor your learning journey from A1 to C2 proficiency.',
      'image': 'assets/images/s4.png',
      'color': const Color(0xFFEC4899),
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  List<Widget> _buildPages() {
    return [
      HomePageContent(
        pageController: _pageController,
        currentFeaturePage: _currentFeaturePage,
        appFeatures: _appFeatures,
        onPageChanged: (index) {
          setState(() {
            _currentFeaturePage = index;
          });
        },
        onNavigateToTab: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      RefreshablePage(key: _articlesKey, child: const TierPage(showBottomNav: false)),
      RefreshablePage(key: _flashcardsKey, child: const FlashcardListPage()),
      RefreshablePage(key: _profileKey, child: const ProfilePage(showBottomNav: false)),
    ];
  }

  void _refreshCurrentPage() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_selectedIndex == 0) {
        setState(() {});
      } else if (_selectedIndex == 1) {
        _articlesKey.currentState?.refresh();
      } else if (_selectedIndex == 2) {
        _flashcardsKey.currentState?.refresh();
      } else if (_selectedIndex == 3) {
        _profileKey.currentState?.refresh();
      }
    });
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentFeaturePage + 1) % _appFeatures.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: IndexedStack(
        index: _selectedIndex,
        children: _buildPages(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF3B82F6),
        unselectedItemColor: Colors.grey[400],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _refreshCurrentPage();
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.article_rounded),
            label: 'Articles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.style_rounded),
            label: 'Flashcard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}


class HomePageContent extends StatelessWidget {
  final PageController pageController;
  final int currentFeaturePage;
  final List<Map<String, dynamic>> appFeatures;
  final Function(int) onPageChanged;
  final Function(int) onNavigateToTab;

  const HomePageContent({
    super.key,
    required this.pageController,
    required this.currentFeaturePage,
    required this.appFeatures,
    required this.onPageChanged,
    required this.onNavigateToTab,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext scaffoldContext) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 48,
                        height: 48,
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        'Vocabulite',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Hello, ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF64748B),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: currentUser?.userName ?? 'User',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF1E293B),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          onNavigateToTab(3);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF59E0B),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  const Text(
                    'About Vocabulite',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    height: 220,
                    child: PageView.builder(
                      controller: pageController,
                      onPageChanged: onPageChanged,
                      itemCount: appFeatures.length,
                      itemBuilder: (context, index) {
                        final feature = appFeatures[index];
                        return Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                feature['color'] as Color,
                                (feature['color'] as Color).withOpacity(0.7),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: (feature['color'] as Color).withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      feature['title'] as String,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      feature['description'] as String,
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        color: Colors.white.withOpacity(0.95),
                                        height: 1.4,
                                      ),
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 2,
                                child: Image.asset(
                                  feature['image'] as String,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 32),

                  const Text(
                    'Learning Progress',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E293B), Color(0xFF334155)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1E293B).withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Tier circles
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TierCircle(tier: 'A1', index: 0),
                            TierCircle(tier: 'A2', index: 1),
                            TierCircle(tier: 'B1', index: 2),
                            TierCircle(tier: 'B2', index: 3),
                            TierCircle(tier: 'C1', index: 4),
                            TierCircle(tier: 'C2', index: 5),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Stats
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      '${currentUser?.completedArticles.length ?? 0}',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Article',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      '${currentUser?.learnedWords.length ?? 0}',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Words',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  const Text(
                    'My Practice',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: MyPracticeCard(
                          title: 'Articles',
                          image: 'assets/images/article.png',
                          category: 'Reading',
                          stat: '${currentUser?.completedArticles.length ?? 0} completed',
                          color: const Color(0xFF06B6D4),
                          onTap: () {
                            onNavigateToTab(1);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: MyPracticeCard(
                          title: 'Quiz',
                          image: 'assets/images/s3.png',
                          category: 'Testing',
                          stat: 'Start now',
                          color: const Color(0xFF9333EA),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const QuizHomePage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: MyPracticeCard(
                          title: 'Flashcards',
                          image: 'assets/images/flashcard.png',
                          category: 'Learning',
                          stat: '${currentUser?.learnedWords.length ?? 0} words',
                          color: const Color(0xFFEC4899),
                          onTap: () {
                            onNavigateToTab(2);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(child: SizedBox()),
                    ],
                  ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TierCircle extends StatelessWidget {
  final String tier;
  final int index;

  const TierCircle({
    super.key,
    required this.tier,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final tierOrder = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];
    final userCurrentTier = currentUser?.currentTier.name ?? 'A1';
    final currentTierIndex = tierOrder.indexOf(userCurrentTier);
    
    final completedTiers = Set.from(currentUser?.completedTiers ?? {});
    bool isCompleted = completedTiers.contains(tier);
    bool isCurrent = index == currentTierIndex;

    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: isCompleted || isCurrent
                ? Colors.white
                : Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: isCompleted
              ? const Icon(
                  Icons.check,
                  color: Color(0xFF10B981),
                  size: 24,
                )
              : Center(
                  child: Text(
                    tier,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isCurrent
                          ? const Color(0xFF3B82F6)
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 6),
        Text(
          tier,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }
}

class MyPracticeCard extends StatelessWidget {
  final String title;
  final String image;
  final String category;
  final String stat;
  final Color color;
  final VoidCallback onTap;

  const MyPracticeCard({
    super.key,
    required this.title,
    required this.image,
    required this.category,
    required this.stat,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    image,
                    height: 70,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      category,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    stat,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RefreshablePage extends StatefulWidget {
  final Widget child;
  
  const RefreshablePage({super.key, required this.child});

  @override
  State<RefreshablePage> createState() => _RefreshablePageState();
}

class _RefreshablePageState extends State<RefreshablePage> {
  Key _childKey = UniqueKey();

  void refresh() {
    setState(() {
      _childKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _childKey,
      child: widget.child,
    );
  }
}
