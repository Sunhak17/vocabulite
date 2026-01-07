import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/flashcard.dart';
import '../models/flashcard_list.dart';

final dummyFlashcards = <Flashcard>[];

final flashcardLists = <FlashcardList>[];

Future<void> loadFlashcardLists(String username) async {
  final prefs = await SharedPreferences.getInstance();
  final listsJson = prefs.getString('flashcard_lists_$username');
  
  flashcardLists.clear();
  
  if (listsJson != null) {
    try {
      final List<dynamic> decoded = jsonDecode(listsJson);
      flashcardLists.addAll(
        decoded.map((json) => FlashcardList.fromJson(json)),
      );
    } catch (e) {
      print('Error loading flashcard lists: $e');
    }
  }
}

Future<void> saveFlashcardLists(String username) async {
  final prefs = await SharedPreferences.getInstance();
  
  final listsJson = jsonEncode(
    flashcardLists.map((list) => list.toJson()).toList(),
  );
  
  await prefs.setString('flashcard_lists_$username', listsJson);
}

Future<void> createFlashcardList(String username, FlashcardList list) async {
  flashcardLists.add(list);
  await saveFlashcardLists(username);
}

Future<void> addWordToList(String username, String listId, Flashcard flashcard) async {
  final index = flashcardLists.indexWhere((list) => list.id == listId);
  if (index != -1) {
    final updatedFlashcards = List<Flashcard>.from(flashcardLists[index].flashcards)..add(flashcard);
    flashcardLists[index] = flashcardLists[index].copyWith(flashcards: updatedFlashcards);
    await saveFlashcardLists(username);
  }
}

/// Remove flashcard from a flashcard list by word
Future<void> removeWordFromList(String username, String listId, String word) async {
  final index = flashcardLists.indexWhere((list) => list.id == listId);
  if (index != -1) {
    final updatedFlashcards = flashcardLists[index].flashcards
        .where((fc) => fc.word != word)
        .toList();
    flashcardLists[index] = flashcardLists[index].copyWith(flashcards: updatedFlashcards);
    await saveFlashcardLists(username);
  }
}

/// Delete a flashcard list
Future<void> deleteFlashcardList(String username, String listId) async {
  flashcardLists.removeWhere((list) => list.id == listId);
  await saveFlashcardLists(username);
}

/// Update flashcard list name
Future<void> updateFlashcardListName(String username, String listId, String newName) async {
  final index = flashcardLists.indexWhere((list) => list.id == listId);
  if (index != -1) {
    flashcardLists[index] = flashcardLists[index].copyWith(name: newName);
    await saveFlashcardLists(username);
  }
}

/// Find or create list for article
FlashcardList? findListByArticleTitle(String articleTitle) {
  try {
    return flashcardLists.firstWhere(
      (list) => list.articleTitle == articleTitle,
    );
  } catch (e) {
    return null;
  }
}

/// Load flashcards from SharedPreferences for current user
Future<void> loadFlashcards(String username) async {
  final prefs = await SharedPreferences.getInstance();
  final flashcardsJson = prefs.getString('flashcards_$username');
  
  dummyFlashcards.clear();
  
  if (flashcardsJson != null) {
    try {
      final List<dynamic> decoded = jsonDecode(flashcardsJson);
      dummyFlashcards.addAll(
        decoded.map((json) => Flashcard(
          word: json['word'] as String,
          definition: json['definition'] as String,
          example: json['example'] as String,
        )),
      );
    } catch (e) {
      print('Error loading flashcards: $e');
    }
  }
}

/// Save flashcards to SharedPreferences for current user
Future<void> saveFlashcards(String username) async {
  final prefs = await SharedPreferences.getInstance();
  
  final flashcardsJson = jsonEncode(
    dummyFlashcards.map((card) => {
      'word': card.word,
      'definition': card.definition,
      'example': card.example,
    }).toList(),
  );
  
  await prefs.setString('flashcards_$username', flashcardsJson);
}


Future<void> addFlashcard(String username, Flashcard flashcard) async {
  dummyFlashcards.add(flashcard);
  await saveFlashcards(username);
}

Future<void> removeFlashcard(String username, int index) async {
  if (index >= 0 && index < dummyFlashcards.length) {
    dummyFlashcards.removeAt(index);
    await saveFlashcards(username);
  }
}

Future<void> updateFlashcard(String username, int index, Flashcard flashcard) async {
  if (index >= 0 && index < dummyFlashcards.length) {
    dummyFlashcards[index] = flashcard;
    await saveFlashcards(username);
  }
}

bool hasFlashcard(String word) {
  return dummyFlashcards.any((card) => card.word.toLowerCase() == word.toLowerCase());
}

Future<void> clearFlashcards() async {
  dummyFlashcards.clear();
}

Future<void> migrateFlashcardLists(String oldUsername, String newUsername) async {
  final prefs = await SharedPreferences.getInstance();
  
  final oldListsJson = prefs.getString('flashcard_lists_$oldUsername');
  
  if (oldListsJson != null) {
    await prefs.setString('flashcard_lists_$newUsername', oldListsJson);
    await prefs.remove('flashcard_lists_$oldUsername');
  }
}
