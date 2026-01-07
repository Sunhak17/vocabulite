import 'flashcard.dart';

class FlashcardList {
  final String id;
  final String name;
  final List<Flashcard> flashcards;
  final String? articleTitle;
  
  FlashcardList({
    required this.id,
    required this.name,
    this.flashcards = const [],
    this.articleTitle,
  });

  FlashcardList.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        flashcards = (json['flashcards'] as List?)
            ?.map((item) => Flashcard.fromJson(item as Map<String, dynamic>))
            .toList() ?? [],
        articleTitle = json['articleTitle'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'flashcards': flashcards.map((fc) => fc.toJson()).toList(),
        'articleTitle': articleTitle,
      };

  FlashcardList copyWith({
    String? id,
    String? name,
    List<Flashcard>? flashcards,
    String? articleTitle,
  }) {
    return FlashcardList(
      id: id ?? this.id,
      name: name ?? this.name,
      flashcards: flashcards ?? this.flashcards,
      articleTitle: articleTitle ?? this.articleTitle,
    );
  }
}
