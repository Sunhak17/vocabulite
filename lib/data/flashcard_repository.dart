import '../model/flashcard.dart';

class FlashcardRepository {
  static final List<Flashcard> _flashcards = [];

  static List<Flashcard> getAll() {
    return List.unmodifiable(_flashcards);
  }

  static void add(Flashcard flashcard) {
    // Check if word already exists
    if (!_flashcards.any((card) => card.word == flashcard.word)) {
      _flashcards.add(flashcard);
    }
  }

  static void remove(String word) {
    _flashcards.removeWhere((card) => card.word == word);
  }

  static int count() {
    return _flashcards.length;
  }
}
