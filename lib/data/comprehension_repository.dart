import '../model/comprehension.dart';

class ComprehensionRepository {
  // Sample comprehension questions for articles
  static final Map<String, List<ComprehensionQuestion>> _questions = {
    // Sample for any article - you can add specific article IDs later
    'default': [
      ComprehensionQuestion(
        question: 'What is the main topic of this article?',
        options: [
          'The benefits of reading',
          'How to write books',
          'Popular book genres',
          'Library management'
        ],
        correctAnswerIndex: 0,
      ),
      ComprehensionQuestion(
        question: 'According to the article, what does reading help improve?',
        options: [
          'Physical health',
          'Vocabulary and imagination',
          'Mathematical skills',
          'Athletic abilities'
        ],
        correctAnswerIndex: 1,
      ),
      ComprehensionQuestion(
        question: 'Which word in the article means "an unusual and exciting experience"?',
        options: [
          'Hobby',
          'Painting',
          'Adventure',
          'Reading'
        ],
        correctAnswerIndex: 2,
      ),
      ComprehensionQuestion(
        question: 'What is described as a regular activity done for enjoyment in free time?',
        options: [
          'Work',
          'Hobby',
          'Exercise',
          'Study'
        ],
        correctAnswerIndex: 1,
      ),
      ComprehensionQuestion(
        question: 'Which activity is mentioned as an example of a creative hobby?',
        options: [
          'Reading books',
          'Watching TV',
          'Painting landscapes',
          'Playing sports'
        ],
        correctAnswerIndex: 2,
      ),
    ],
  };

  static List<ComprehensionQuestion> getQuestionsForArticle(String articleId) {
    return _questions[articleId] ?? _questions['default']!;
  }
}
