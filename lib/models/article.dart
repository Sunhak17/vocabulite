import 'tier.dart';

class Article {
  final String id;
  final Tier tier;
  final String title;
  final String summary;
  final String content;

  Article({
    required this.id,
    required this.tier,
    required this.title,
    required this.summary,
    required this.content,
  });

  Article.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        tier = Tier.values.byName(json['tier'] as String),
        title = json['title'] as String,
        summary = json['summary'] as String,
        content = json['content'] as String;

  Map<String, dynamic> toJson() => {
        'id': id,
        'tier': tier.name,
        'title': title,
        'summary': summary,
        'content': content,
      };
}
