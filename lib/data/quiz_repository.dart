import '../model/quiz.dart';

class QuizRepository {
  static List<Quiz> getSampleQuizzes() {
    return [
      Quiz(
        question: 'I usually read for ___ in the evening.',
        options: ['one hour', '3 days', 'a week', 'one month'],
        correctAnswer: 'one hour',
        level: 'A2',
      ),
      Quiz(
        question: 'Which word is a type of exciting story?',
        options: ['Homework', 'Adventure', 'Sad', 'School'],
        correctAnswer: 'Adventure',
        level: 'A2',
      ),
      Quiz(
        question: 'My hobby is ___ skateboarding.',
        options: ['doing', 'playing', 'making', 'going'],
        correctAnswer: 'doing',
        level: 'A2',
      ),
      Quiz(
        question: 'What do you do in your ___ time?',
        options: ['free', 'busy', 'work', 'sleep'],
        correctAnswer: 'free',
        level: 'A2',
      ),
      Quiz(
        question: 'She enjoys ___ novels.',
        options: ['read', 'reading', 'to read', 'reads'],
        correctAnswer: 'reading',
        level: 'A2',
      ),
    ];
  }

  static List<Quiz> getQuizzesByLevel(String level) {
    return getSampleQuizzes()
        .where((quiz) => quiz.level == level)
        .toList();
  }
}
