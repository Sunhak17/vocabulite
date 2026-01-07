import 'package:flutter/material.dart';
import '../../models/flashcard_list.dart';
import '../../models/flashcard.dart';
import '../../data/flashcard_repository.dart';
import '../../data/user_progress_repository.dart';
import '../../data/vocabulary_repository.dart';

Future<String?> showFlashcardListSelector({
  required BuildContext context,
  required String word,
  String? articleTitle,
}) async {
  final existingList = articleTitle != null ? findListByArticleTitle(articleTitle) : null;

  return showDialog<String>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text('Add "$word" to list'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (flashcardLists.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'No lists available. Create one below.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              else
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: flashcardLists.length,
                    itemBuilder: (context, index) {
                      final list = flashcardLists[index];
                      final isFromArticle = list.articleTitle == articleTitle;
                      
                      return ListTile(
                        leading: Icon(
                          isFromArticle ? Icons.star : Icons.list,
                          color: isFromArticle ? const Color(0xFFF59E0B) : const Color(0xFF1976D2),
                        ),
                        title: Text(list.name),
                        subtitle: Text('${list.flashcards.length} words'),
                        trailing: isFromArticle 
                            ? const Chip(
                                label: Text(
                                  'Suggested',
                                  style: TextStyle(fontSize: 10, color: Colors.white),
                                ),
                                backgroundColor: Color(0xFFF59E0B),
                                padding: EdgeInsets.symmetric(horizontal: 4),
                              )
                            : null,
                        onTap: () => Navigator.pop(ctx, list.id),
                      );
                    },
                  ),
                ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.add_circle, color: Color(0xFF10B981)),
                title: Text(
                  existingList != null
                      ? 'Create new list'
                      : 'Create new list for "${articleTitle ?? 'this article'}"',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () => Navigator.pop(ctx, 'create_new'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}

/// Add a word to a flashcard list or create a new list
Future<void> addWordToFlashcardList({
  required BuildContext context,
  required String word,
  String? articleTitle,
}) async {
  final listId = await showFlashcardListSelector(
    context: context,
    word: word,
    articleTitle: articleTitle,
  );

  if (listId == null) return;

  if (listId == 'create_new') {
    // Show dialog to create new list
    final listName = await showDialog<String>(
      context: context,
      builder: (ctx) {
        final controller = TextEditingController(
          text: articleTitle ?? 'New Flashcard List',
        );
        return AlertDialog(
          title: const Text('Create New List'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'List name',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, controller.text),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
              ),
              child: const Text('Create'),
            ),
          ],
        );
      },
    );

    if (listName != null && listName.trim().isNotEmpty) {
      // Get word definition from vocabulary
      final vocabData = VocabularyRepository.vocabulary[word.toLowerCase()];
      final definition = vocabData?['definition'] ?? 'No definition available';
      final examples = vocabData?['examples'] as List?;
      final example = examples?.isNotEmpty == true ? examples!.first : 'No example available';
      
      final flashcard = Flashcard(
        word: word,
        definition: definition,
        example: example,
      );
      
      final newList = FlashcardList(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: listName.trim(),
        flashcards: [flashcard],
        articleTitle: articleTitle,
      );
      await createFlashcardList(currentUser!.userName, newList);
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Created list "$listName" with word "$word"'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  } else {
    // Check if word already exists in the list
    final list = flashcardLists.firstWhere((l) => l.id == listId);
    
    if (list.flashcards.any((fc) => fc.word == word)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Word "$word" already in "${list.name}"'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }
    
    // Get word definition from vocabulary
    final vocabData = VocabularyRepository.vocabulary[word.toLowerCase()];
    final definition = vocabData?['definition'] ?? 'No definition available';
    final examples = vocabData?['examples'] as List?;
    final example = examples?.isNotEmpty == true ? examples!.first : 'No example available';
    
    // Create flashcard object
    final flashcard = Flashcard(
      word: word,
      definition: definition,
      example: example,
    );
    
    await addWordToList(currentUser!.userName, listId, flashcard);
    
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added "$word" to "${list.name}"'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
