import 'package:flutter/material.dart';
import 'ui/welcome_page.dart';
import 'ui/level_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VocabuLite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/levels': (context) => const LevelPage(),
      },
    );
  }
}
