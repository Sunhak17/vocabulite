# VocabuLite

A comprehensive English learning mobile application built with Flutter, designed to help learners progress from beginner (A1) to proficiency (C2) level through structured reading materials, interactive quizzes, and flashcard systems.

## Features

### 📚 Level-Based Learning System
- **6 CEFR Levels**: A1 (Beginner) → A2 (Elementary) → B1 (Intermediate) → B2 (Upper Intermediate) → C1 (Advanced) → C2 (Proficiency)
- **Progressive Unlocking**: Users start at A1 and unlock higher levels by completing quizzes with 70%+ scores
- **Structured Progression**: Each level must be completed before accessing the next, ensuring solid foundation building

### 📖 Reading Articles
- Curated articles for each proficiency level
- Interactive vocabulary highlighting with definitions and examples
- Reading time estimates and word counts
- Clickable word definitions with usage examples

### 🎯 Quiz System
- Level-specific comprehension quizzes
- Multiple-choice questions
- Instant feedback with correct answers
- Score tracking with percentage display
- Level completion upon achieving 70%+ score
- Next level unlock notifications

### 💳 Flashcard System
- Save vocabulary words from articles
- Personal study lists
- Word definitions and example sentences
- Easy access to review saved words

### 👤 User Profile
- Personalized onboarding experience
- User name display throughout the app
- Current level badge display
- Learning journey visualization
- Progress tracking across levels

## Level Progression System

### How It Works
1. **Start**: All users begin at A1 (Beginner) level
2. **Learn**: Read articles and study vocabulary for current level
3. **Test**: Take quizzes to assess comprehension
4. **Progress**: Score 70% or higher to complete the level
5. **Unlock**: Next level automatically becomes accessible
6. **Repeat**: Continue through all 6 levels to proficiency

### Level Indicators
- 🟢 **Unlocked**: Available to study
- ✓ **Completed**: Successfully finished with 70%+ score
- 🔒 **Locked**: Complete previous levels to unlock

## Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / Xcode for device/emulator
- Git

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/vocabulite.git
cd vocabulite
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
flutter run
```

## Project Features in Detail

### User Onboarding
- Welcome screen with app introduction
- Profile setup with name input
- Learning journey visualization showing all 6 levels
- Clear explanation of progression system

### Article Reading Experience
- Clean, readable interface
- Highlighted vocabulary words
- Tap-to-reveal definitions
- Example sentences for context
- Add words directly to flashcards

### Quiz System
- Multiple choice format
- Detailed results page showing:
  - Total score (correct/total)
  - Percentage achieved
  - Pass/Fail status (70% threshold)
  - Question-by-question review
  - Level completion notification
  - Next level unlock alert

### Navigation
Consistent bottom navigation bar across main pages:
- 🏠 Home
- 📄 Articles
- 🎯 Quiz
- 💳 Flashcards
- 👤 Profile

## Technical Stack

- **Framework**: Flutter 3.x
- **Language**: Dart 3.x
- **State Management**: setState (StatefulWidget)
- **Data Storage**: In-memory repositories (can be extended to SharedPreferences/SQLite)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

For questions or feedback, please open an issue on GitHub.

---

## Credits

**Course**: Fundamental of Mobile Development  
**Lecturer**: Lect.Ronan Ogor  
**Institution**: Cambodia Academy of Digital Technology

---

**Happy Learning! 📚✨**


