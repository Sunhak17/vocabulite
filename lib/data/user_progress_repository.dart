import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'flashcard_repository.dart';
import '../models/user.dart';
import '../models/tier.dart';

User? currentUser;

Future<void> saveUserData({String? password}) async {
  if (currentUser == null) return;

  final prefs = await SharedPreferences.getInstance();
  
  final userData = currentUser!.toJson();

  await prefs.setString('user_${currentUser!.userName}', jsonEncode(userData));
  
  if (password != null) {
    await prefs.setString('password_${currentUser!.userName}', password);
  }

  List<String> usersList = prefs.getStringList('users_list') ?? [];
  
  if (!usersList.contains(currentUser!.userName)) {
    usersList.add(currentUser!.userName);
  }

  await prefs.setStringList('users_list', usersList);
  await prefs.setString('current_user', currentUser!.userName);
}

Future<bool> loadUserData(String username) async {
  final prefs = await SharedPreferences.getInstance();
  final userDataString = prefs.getString('user_$username');

  if (userDataString == null) {
    return false;
  }

  try {
    final userData = jsonDecode(userDataString) as Map<String, dynamic>;

    currentUser = User.fromJson(userData);
    
    currentUser!.syncCurrentTier();

    await prefs.setString('current_user', username);

    await loadFlashcardLists(username);

    return true; 
  } catch (e) {
    return false;
  }
}

Future<void> createNewUser(String username, String password, {String? profileImage}) async {
  currentUser = User(
    userName: username,
    currentTier: Tier.A1,
    profileImage: profileImage,
  );

  await saveUserData(password: password);
}

Future<bool> validateUserPassword(String username, String password) async {
  final prefs = await SharedPreferences.getInstance();
  final storedPassword = prefs.getString('password_$username');
  return storedPassword == password;
}

Future<bool> userExists(String username) async {
  final prefs = await SharedPreferences.getInstance();
  final userDataString = prefs.getString('user_$username');
  return userDataString != null;
}

Future<bool> updateUsername(String oldUsername, String newUsername) async {
  if (oldUsername == newUsername) return true;
  
  if (await userExists(newUsername)) {
    return false; 
  }
  
  final prefs = await SharedPreferences.getInstance();
  
  final oldUserData = prefs.getString('user_$oldUsername');
  final oldPassword = prefs.getString('password_$oldUsername');
  
  if (oldUserData == null) return false;
  
  if (currentUser != null) {
    currentUser!.userName = newUsername;
  }
  
  await prefs.setString('user_$newUsername', oldUserData);
  
  if (oldPassword != null) {
    await prefs.setString('password_$newUsername', oldPassword);
  }
  
  List<String> usersList = prefs.getStringList('users_list') ?? [];
  usersList.remove(oldUsername);
  if (!usersList.contains(newUsername)) {
    usersList.add(newUsername);
  }
  await prefs.setStringList('users_list', usersList);
  
  await prefs.setString('current_user', newUsername);
  
  await prefs.remove('user_$oldUsername');
  await prefs.remove('password_$oldUsername');
  
  await migrateFlashcardLists(oldUsername, newUsername);
  
  return true;
}


Future<String?> getLastUser() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('current_user');
}

Future<List<String>> getAllUsers() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('users_list') ?? [];
}

Future<bool> hasAnyUser() async {
  final users = await getAllUsers();
  return users.isNotEmpty;
}

Future<void> clearCurrentUser() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');

  currentUser = null;
  
  await clearFlashcards();
}

Future<void> resetAllData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  
  currentUser = null;
  
  await clearFlashcards();
}

Future<void> saveQuizResult({
  required String tier,
  required int score,
  required int totalQuestions,
  String? articleId,
}) async {
  if (currentUser == null) return;
  
  if (tier.isEmpty || tier.toLowerCase() == 'null') {
    if (articleId != null && articleId.isNotEmpty) {
      final tierMatch = RegExp(r'^([a-z]\d+)', caseSensitive: false).firstMatch(articleId);
      tier = tierMatch?.group(1)?.toUpperCase() ?? 'A1';
    } else {
      tier = 'A1'; 
    }
  }

  final quizResult = {
    'tier': tier,
    'score': score,
    'total': totalQuestions,
    'percentage': ((score / totalQuestions) * 100).round(),
    'articleId': articleId,
    'date': DateTime.now().toIso8601String(),
  };

  currentUser!.addQuizToHistory(quizResult);

  final percentage = (score / totalQuestions * 100).round();
  if (percentage >= 70) {
    final quizId = articleId ?? tier;
    currentUser!.completeQuiz(quizId);
  }

  await saveUserData();
}
