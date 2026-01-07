import 'package:flutter/material.dart';
import 'ui/screens/welcome_page.dart';
import 'ui/screens/home_page.dart';
import 'ui/screens/article/Tier_page.dart';
import 'data/user_progress_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VocabuLite',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AppInitializer(),
      routes: {'/Tiers': (context) => const TierPage()},
    );
  }
}

/// Widget to check if user exists and route accordingly
class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Check if there's a last logged-in user
    final lastUser = await getLastUser();

    if (lastUser != null) {
      // Load the last user's data
      await loadUserData(lastUser);

      // Navigate to home page
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    } else {
      // No existing user, show splash page
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SplashPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show loading screen while checking
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}
