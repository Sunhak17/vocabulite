import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'VocabuLite',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 200, 1),
                  fontSize: 54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                // width: 160,
                // height: 160,
                // decoration: BoxDecoration(
                //   color: Colors.white24,
                //   shape: BoxShape.circle,
                // ),
                child: Center(
                  child: Image.asset(
                    'assets/logo.png',
                    width: 300,
                    height: 300,
                    // fit: BoxFit.contain,
                    // errorBuilder: (context, error, stackTrace) {
                    //   return const Icon(
                    //     Icons.book,
                    //     color: Colors.white,
                    //     size: 72,
                    //   );
                    // },
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 36.0),
                child: Text(
                  'Improve fluency, vocabulary, and grammar with offline tasks, smart flashcards, and quick quizzes.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[700],
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Navigator.pushNamed(context, '/levels'),
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
