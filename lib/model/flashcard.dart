class Flashcard {
  final String word;
  final String definition;
  final String example;

  Flashcard({
    required this.word,
    required this.definition,
    required this.example,
  });

  Map<String, dynamic> toJson() => {
        'word': word,
        'definition': definition,
        'example': example,
      };

  factory Flashcard.fromJson(Map<String, dynamic> json) => Flashcard(
        word: json['word'] as String,
        definition: json['definition'] as String,
        example: json['example'] as String,
      );
}
