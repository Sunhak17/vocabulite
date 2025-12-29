import 'package:flutter/material.dart';
import '../model/article.dart';

class ArticleDetail extends StatelessWidget {
  final Article article;
  const ArticleDetail({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(article.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Level: ${article.level}', style: const TextStyle(color: Colors.orange)),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Text(article.content, style: const TextStyle(fontSize: 16, height: 1.4)),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Start quiz (placeholder)')));
                    },
                    child: const Text('Take Challenges'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
