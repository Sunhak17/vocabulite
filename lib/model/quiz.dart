class Quiz {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String level;

  Quiz({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.level,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      question: json['question'] as String,
      options: List<String>.from(json['options'] as List),
      correctAnswer: json['correctAnswer'] as String,
      level: json['level'] as String,
    );
  }
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
