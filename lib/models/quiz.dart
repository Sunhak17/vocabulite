import 'tier.dart';

class Quiz {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final Tier tier;
  final String? articleId; 

  Quiz({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.tier,
    this.articleId,
  });

  Quiz.fromJson(Map<String, dynamic> json)
      : question = json['question'] as String,
        options = List<String>.from(json['options'] as List),
        correctAnswer = json['correctAnswer'] as String,
        tier = Tier.values.byName(json['tier'] as String),
        articleId = json['articleId'] as String?;
}

class QuizResult {
  final String question;
  final String userAnswer;
  final String correctAnswer;
  final bool isCorrect;

  QuizResult({
    required this.question,
    required this.userAnswer,
    required this.correctAnswer,
  }) : isCorrect = userAnswer == correctAnswer;
}
