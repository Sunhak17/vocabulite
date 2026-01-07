class Flashcard {
  final String word;
  final String definition;
  final String example;

  Flashcard({
    required this.word,
    required this.definition,
    required this.example,
  });

  Flashcard.fromJson(Map<String, dynamic> json)
      : word = json['word'] as String,
        definition = json['definition'] as String,
        example = json['example'] as String;

  Map<String, dynamic> toJson() => {
        'word': word,
        'definition': definition,
        'example': example,
      };
}
