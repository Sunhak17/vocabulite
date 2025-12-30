class ComprehensionQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  ComprehensionQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class ArticleComprehension {
  final String articleId;
  final List<ComprehensionQuestion> questions;

  ArticleComprehension({
    required this.articleId,
    required this.questions,
  });
}
