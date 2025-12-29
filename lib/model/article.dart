class Article {
  final String id;
  final String level; // A1..C2
  final String title;
  final String summary;
  final String content;
  final String? image;

  Article({
    required this.id,
    required this.level,
    required this.title,
    required this.summary,
    required this.content,
    this.image,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json['id'] as String,
        level: json['level'] as String,
        title: json['title'] as String,
        summary: json['summary'] as String,
        content: json['content'] as String,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'level': level,
        'title': title,
        'summary': summary,
        'content': content,
        'image': image,
      };
}
