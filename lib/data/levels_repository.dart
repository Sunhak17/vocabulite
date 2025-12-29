import 'dart:convert';
import 'package:flutter/services.dart';
import '../model/article.dart';

class LevelsRepository {
  static List<Article>? _cache;

  static Future<List<Article>> loadAll() async {
    if (_cache != null) return _cache!;
    final raw = await rootBundle.loadString('assets/levels.json');
    final list = jsonDecode(raw) as List<dynamic>;
    _cache = list.map((e) => Article.fromJson(e as Map<String, dynamic>)).toList();
    return _cache!;
  }

  static Future<List<Article>> loadByLevel(String level) async {
    final all = await loadAll();
    return all.where((a) => a.level.toUpperCase() == level.toUpperCase()).toList();
  }
}
