class UserProgressRepository {
  // In-memory storage for user data
  static String? _userName;
  static String? _currentLevel;
  static final Set<String> _completedLevels = {};
  
  // Level order for progression
  static const List<String> _levelOrder = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

  // User name
  static String? getUserName() => _userName;
  
  static void setUserName(String name) {
    _userName = name;
  }

  // Current level (user's selected level in profile setup)
  static String? getCurrentLevel() => _currentLevel;
  
  static void setCurrentLevel(String level) {
    _currentLevel = level;
  }

  // Check if profile is set up
  static bool isProfileSetup() {
    return _userName != null && _currentLevel != null;
  }

  // Check if a level is unlocked
  static bool isLevelUnlocked(String level) {
    if (_currentLevel == null) return false;
    
    int currentIndex = _levelOrder.indexOf(_currentLevel!);
    int requestedIndex = _levelOrder.indexOf(level.toUpperCase());
    
    if (currentIndex == -1 || requestedIndex == -1) return false;
    
    // User can access their level and below
    if (requestedIndex <= currentIndex) return true;
    
    // For levels above current level, check if previous level is completed
    // To access a higher level, all previous levels must be completed
    for (int i = currentIndex; i < requestedIndex; i++) {
      if (!_completedLevels.contains(_levelOrder[i])) {
        return false;
      }
    }
    
    return true;
  }

  // Mark a level as completed
  static void completeLevel(String level) {
    _completedLevels.add(level.toUpperCase());
  }

  // Check if a level is completed
  static bool isLevelCompleted(String level) {
    return _completedLevels.contains(level.toUpperCase());
  }

  // Get all completed levels
  static Set<String> getCompletedLevels() {
    return Set.from(_completedLevels);
  }

  // Calculate completion percentage for a level (based on articles read or quizzes passed)
  static final Map<String, int> _levelProgress = {};
  
  static int getLevelProgress(String level) {
    return _levelProgress[level.toUpperCase()] ?? 0;
  }
  
  static void updateLevelProgress(String level, int progress) {
    _levelProgress[level.toUpperCase()] = progress;
    // If progress reaches 100%, mark level as completed
    if (progress >= 100) {
      completeLevel(level);
    }
  }

  // Get the next available level
  static String? getNextLevel() {
    if (_currentLevel == null) return null;
    
    int currentIndex = _levelOrder.indexOf(_currentLevel!);
    if (currentIndex == -1 || currentIndex >= _levelOrder.length - 1) return null;
    
    // Check if current level is completed
    if (_completedLevels.contains(_currentLevel!)) {
      return _levelOrder[currentIndex + 1];
    }
    
    return null;
  }

  // Reset all progress (for testing purposes)
  static void reset() {
    _userName = null;
    _currentLevel = null;
    _completedLevels.clear();
    _levelProgress.clear();
  }
}
