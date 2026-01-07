import 'package:flutter/material.dart';
import '../../../models/quiz.dart';
import '../../../models/tier.dart';
import '../../../data/user_progress_repository.dart';

class QuizResultPage extends StatefulWidget {
  final List<QuizResult> results;
  final String tier;
  final String? articleId;

  const QuizResultPage({
    super.key,
    required this.results,
    required this.tier,
    this.articleId,
  });

  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {
  bool _TierUnlocked = false;
  String? _nextTier;

  @override
  void initState() {
    super.initState();
    _checkTierCompletion();
  }

  void _checkTierCompletion() async {
    final correctCount = widget.results.where((r) => r.isCorrect).length;
    final totalCount = widget.results.length;
    final percentage = (correctCount / totalCount * 100).round();

    await saveQuizResult(
      tier: widget.tier,
      score: correctCount,
      totalQuestions: totalCount,
      articleId: widget.articleId,
    );

    if (percentage >= 70 &&
        currentUser != null &&
        !currentUser!.completedTiers.contains(widget.tier.toUpperCase())) {
      
      currentUser!.completeTier(widget.tier.toUpperCase());

      const tierOrder = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];
      final currentIndex = tierOrder.indexOf(widget.tier.toUpperCase());
      if (currentIndex != -1 && currentIndex < tierOrder.length - 1) {
        final nextTierName = tierOrder[currentIndex + 1];
        currentUser!.currentTier = Tier.values.byName(nextTierName);
      }

      if (widget.articleId != null) {
        currentUser!.completeArticle(widget.articleId!);
      }

      await saveUserData();

      _nextTier = _getNextTierInSequence(widget.tier);
      setState(() {
        _TierUnlocked = true;
      });
    }
  }

  String? _getNextTierInSequence(String currentTier) {
    const Tiers = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];
    final index = Tiers.indexOf(currentTier.toUpperCase());
    if (index != -1 && index < Tiers.length - 1) {
      return Tiers[index + 1];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final correctCount = widget.results.where((r) => r.isCorrect).length;
    final totalCount = widget.results.length;
    final percentage = (correctCount / totalCount * 100).round();
    final passed = percentage >= 70;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1976D2), Color(0xFF64B5F6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                    const Text(
                      'Quiz',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Result',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: passed
                        ? const Color(0xFF43A047)
                        : const Color(0xFFF59E0B),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'My Favorite Hobby',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'tier: ${widget.tier}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '$correctCount / $totalCount correct ($percentage%)',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        passed ? '✓ tier Completed!' : 'Keep practicing!',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      if (_TierUnlocked) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.lock_open,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _nextTier != null
                                    ? 'Next tier unlocked: $_nextTier'
                                    : 'tier completed!',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Questions and answers
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  itemCount: widget.results.length,
                  itemBuilder: (context, index) {
                    final result = widget.results[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Q${index + 1}: ${result.question}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (!result.isCorrect) ...[
                            Text(
                              'Your Answer: ${result.userAnswer}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                          ],
                          Text(
                            'Correct Answer: ${result.correctAnswer}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF59E0B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
