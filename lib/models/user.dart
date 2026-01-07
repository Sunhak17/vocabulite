import 'tier.dart';
import '../data/tiers_repository.dart';

class User {
  String userName;
  String? profileImage;
  Tier currentTier;
  Set<String> completedTiers;
  Set<String> completedArticles;
  Set<String> learnedWords;
  Map<String, int> tierProgress;
  List<Map<String, dynamic>> quizHistory;
  Set<String> completedQuizzes;

  User({
    required this.userName,
    this.profileImage,
    this.currentTier = Tier.A1,
    Set<String>? completedTiers,
    Set<String>? completedArticles,
    Set<String>? learnedWords,
    Map<String, int>? tierProgress,
    List<Map<String, dynamic>>? quizHistory,
    Set<String>? completedQuizzes,
  })  : completedTiers = completedTiers ?? {},
        completedArticles = completedArticles ?? {},
        learnedWords = learnedWords ?? {},
        tierProgress = tierProgress ?? {},
        quizHistory = quizHistory ?? [],
        completedQuizzes = completedQuizzes ?? {};

 
  void completeArticle(String articleId) {
    completedArticles.add(articleId);
    _checkAndUpdateTier();
  }

  void completeTier(String tierId) {
    completedTiers.add(tierId);
  }

  bool hasCompletedTier(String tier) {
    return completedTiers.contains(tier);
  }

  bool hasCompletedArticle(String articleId) {
    return completedArticles.contains(articleId);
  }

  void learnWord(String word) {
    learnedWords.add(word);
    _checkAndUpdateTier();
  }

  void updateTierProgress(String tier, int progress) {
    tierProgress[tier] = progress;
  }

  void _checkAndUpdateTier() {
    const tierOrder = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];
    final currentTierName = currentTier.name;
    final currentIndex = tierOrder.indexOf(currentTierName);
    
    final currentTierArticles = dummyArticles
        .where((article) => article.tier.name.toUpperCase() == currentTierName.toUpperCase())
        .toList();
    
    final completedInCurrentTier = currentTierArticles
        .where((article) => completedArticles.contains(article.id))
        .length;
    
    // Calculate completion percentage
    final totalArticlesInTier = currentTierArticles.length;
    final completionPercentage = totalArticlesInTier > 0
        ? (completedInCurrentTier / totalArticlesInTier) * 100
        : 0.0;
    
    tierProgress[currentTierName] = completionPercentage.round();
    
    // Requirements to advance to next tier: 70% completion
    if (completionPercentage >= 70.0) {
      if (currentIndex < tierOrder.length - 1) {
        final nextTierName = tierOrder[currentIndex + 1];
        currentTier = Tier.values.byName(nextTierName);
        completeTier(currentTierName);
      }
    }
  }
  
  double getTierCompletionPercentage(String tierName) {
    final tierArticles = dummyArticles
        .where((article) => article.tier.name.toUpperCase() == tierName.toUpperCase())
        .toList();
    
    if (tierArticles.isEmpty) return 0.0;
    
    final completedInTier = tierArticles
        .where((article) => completedArticles.contains(article.id))
        .length;
    
    return (completedInTier / tierArticles.length) * 100;
  }

  void syncCurrentTier() {
    if (completedTiers.isEmpty) {
      currentTier = Tier.A1;
      return;
    }
    
    const tierOrder = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];
    
    String highestCompleted = 'A1';
    for (final tier in tierOrder) {
      if (completedTiers.contains(tier)) {
        highestCompleted = tier;
      } else {
        break; 
      }
    }
    
    final currentIndex = tierOrder.indexOf(highestCompleted);
    if (currentIndex < tierOrder.length - 1) {
      currentTier = Tier.values.byName(tierOrder[currentIndex + 1]);
    } else {
      currentTier = Tier.values.byName(highestCompleted);
    }
  }
  int getTierProgress(String tier) {
    return tierProgress[tier] ?? 0;
  }

  void addQuizToHistory(Map<String, dynamic> quiz) {
    quizHistory.add(quiz);
  }

  void completeQuiz(String quizId) {
    completedQuizzes.add(quizId);
  }

  bool hasCompletedQuiz(String quizId) {
    return completedQuizzes.contains(quizId);
  }

  Map<String, dynamic> toJson() {
    return {
      'username': userName,
      'currentTier': currentTier.name,
      'profileImage': profileImage,
      'completedTiers': completedTiers.toList(),
      'completedArticles': completedArticles.toList(),
      'learnedWords': learnedWords.toList(),
      'TierProgress': tierProgress,
      'quizHistory': quizHistory,
      'completedQuizzes': completedQuizzes.toList(),
    };
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['username'] as String,
      currentTier: json['currentTier'] != null 
          ? Tier.values.byName(json['currentTier'] as String)
          : Tier.A1,
      profileImage: json['profileImage'] as String?,
      completedTiers: json['completedTiers'] != null
          ? Set<String>.from(json['completedTiers'])
          : null,
      completedArticles: json['completedArticles'] != null
          ? Set<String>.from(json['completedArticles'])
          : null,
      learnedWords: json['learnedWords'] != null
          ? Set<String>.from(json['learnedWords'])
          : null,
      tierProgress: json['TierProgress'] != null
          ? Map<String, int>.from(
              (json['TierProgress'] as Map<String, dynamic>)
                  .map((key, value) => MapEntry(key, value as int)))
          : null,
      quizHistory: json['quizHistory'] != null
          ? List<Map<String, dynamic>>.from(json['quizHistory'])
          : null,
      completedQuizzes: json['completedQuizzes'] != null
          ? Set<String>.from(json['completedQuizzes'])
          : null,
    );
  }
}