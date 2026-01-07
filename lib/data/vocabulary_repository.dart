import 'package:flutter/material.dart';

// Enum for word difficulty levels
enum WordDifficulty {
  easy,
  medium,
  hard,
}

// Vocabulary repository for storing word definitions and examples
class VocabularyRepository {
  // Define vocabulary words and their definitions with examples
  static final Map<String, Map<String, dynamic>> vocabulary = {
    // A1 Level - Basic words
    'hello': {
      'definition': '[interjection] a greeting used when meeting someone',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'Hello! How are you today?',
        'I say hello to my teacher every morning.',
      ],
    },
    'friends': {
      'definition': '[noun] people you know well and like',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'I play with my friends at school.',
        'My friends and I like to read together.',
      ],
    },
    'school': {
      'definition': '[noun] a place where children go to learn',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'I go to school every day.',
        'My school has a big library.',
      ],
    },
    'count': {
      'definition': '[verb] to say numbers in order',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'I can count to one hundred.',
        'Let me count how many books you have.',
      ],
    },
    'blue': {
      'definition': '[adjective] the color of the sky on a clear day',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'The sky is blue today.',
        'My favorite color is blue.',
      ],
    },
    'green': {
      'definition': '[adjective] the color of grass and leaves',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'The grass is green in spring.',
        'I have a green shirt.',
      ],
    },
    'family': {
      'definition': '[noun] a group of people related to each other',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'I love my family very much.',
        'My family likes to eat dinner together.',
      ],
    },
    'mother': {
      'definition': '[noun] a female parent',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'My mother is very kind.',
        'I help my mother cook dinner.',
      ],
    },
    'father': {
      'definition': '[noun] a male parent',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'My father works in an office.',
        'I play soccer with my father on weekends.',
      ],
    },
    'brother': {
      'definition': '[noun] a male who has the same parents as you',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'I have one younger brother.',
        'My brother and I share a room.',
      ],
    },
    'park': {
      'definition': '[noun] a public area with grass and trees',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'We play in the park every weekend.',
        'The park has a playground for children.',
      ],
    },
    
    // A2 Level
    'reading': {
      'definition': '[verb] the action of reading books or other written material',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'I enjoy reading before bed every night.',
        'Reading helps improve your vocabulary and imagination.',
      ],
    },
    'books': {
      'definition': '[noun] a written or printed work consisting of pages',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'The library has thousands of books on various topics.',
        'She borrowed three books from the bookstore.',
      ],
    },
    'adventure': {
      'definition': '[noun] an unusual and exciting experience or activity',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'Their trip to the mountains was a great adventure.',
        'He loves stories about adventure and exploration.',
      ],
    },
    'exciting': {
      'definition': '[adjective] causing great enthusiasm and eagerness',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'The football match was very exciting to watch.',
        'Starting a new job can be exciting and challenging.',
      ],
    },
    'improve': {
      'definition': '[verb] make or become better',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'Practice will help you improve your skills.',
        'The weather is starting to improve.',
      ],
    },
    'hobby': {
      'definition': '[noun] a regular activity done for enjoyment in free time',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'Photography is my favorite hobby.',
        'What hobbies do you have?',
      ],
    },
    'usually': {
      'definition': '[adverb] in most cases; normally',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'I usually wake up at 7 AM.',
        'She usually drinks coffee in the morning.',
      ],
    },
    'picnic': {
      'definition': '[noun] an outdoor meal, typically in a park',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'We had a picnic by the lake.',
        'They brought sandwiches for the picnic.',
      ],
    },
    'weather': {
      'definition': '[noun] the state of the atmosphere at a place and time',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'The weather is sunny today.',
        'I check the weather forecast before going out.',
      ],
    },
    'sunny': {
      'definition': '[adjective] bright with sunlight',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'It is a sunny day perfect for the beach.',
        'I love sunny weather.',
      ],
    },
    'delicious': {
      'definition': '[adjective] very pleasant to taste',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'The pizza tastes delicious!',
        'She cooked a delicious meal for us.',
      ],
    },
    'pizza': {
      'definition': '[noun] a flat round bread with toppings',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'I love eating pizza on weekends.',
        'We ordered a large pizza for dinner.',
      ],
    },
    'cheese': {
      'definition': '[noun] a food made from milk',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'I like cheese on my sandwich.',
        'This pizza has a lot of cheese.',
      ],
    },
    'weekend': {
      'definition': '[noun] Saturday and Sunday',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'I relax on the weekend.',
        'What are your plans for the weekend?',
      ],
    },
    
    // B1 Level
    'journey': {
      'definition': '[noun] an act of traveling from one place to another',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'The journey took five hours by car.',
        'Their journey across the country was memorable.',
      ],
    },
    'landscapes': {
      'definition': '[noun] all the visible features of an area of land',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'The artist is famous for painting beautiful landscapes.',
        'Mountain landscapes are breathtaking in autumn.',
      ],
    },
    'cultures': {
      'definition': '[noun] the customs and beliefs of a particular group',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'Learning about different cultures is fascinating.',
        'Each country has its own unique culture.',
      ],
    },
    'shopping': {
      'definition': '[noun] the activity of buying things from stores',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'I enjoy shopping for clothes.',
        'We went shopping at the mall yesterday.',
      ],
    },
    'compare': {
      'definition': '[verb] to examine similarities and differences',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'I always compare prices before buying.',
        'Let me compare these two options.',
      ],
    },
    'helpful': {
      'definition': '[adjective] giving or ready to give help',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'The staff were very helpful.',
        'Thank you for being so helpful.',
      ],
    },
    'healthy': {
      'definition': '[adjective] in good physical condition',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'Eating fruits keeps you healthy.',
        'Exercise is important for a healthy life.',
      ],
    },
    'exercise': {
      'definition': '[noun] physical activity to stay fit',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'I exercise three times a week.',
        'Regular exercise improves your health.',
      ],
    },
    'vegetables': {
      'definition': '[noun] plants used as food',
      'difficulty': WordDifficulty.easy,
      'examples': [
        'Vegetables are good for your health.',
        'I eat vegetables every day.',
      ],
    },
    'strength': {
      'definition': '[noun] the quality of being physically strong',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'Lifting weights builds strength.',
        'She has great physical strength.',
      ],
    },
    
    // B2 Level
    'career': {
      'definition': '[noun] a job or profession that someone does for a long time',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'She has a successful career in medicine.',
        'Choosing the right career is important.',
      ],
    },
    'technology': {
      'definition': '[noun] the application of scientific knowledge for practical purposes',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'Technology has changed our daily lives.',
        'I am interested in computer technology.',
      ],
    },
    'professional': {
      'definition': '[adjective] relating to a job that requires special training',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'She is a professional photographer.',
        'Professional development is important for growth.',
      ],
    },
    'essential': {
      'definition': '[adjective] absolutely necessary; extremely important',
      'difficulty': WordDifficulty.hard,
      'examples': [
        'Water is essential for life.',
        'Good communication is essential in business.',
      ],
    },
    'achieve': {
      'definition': '[verb] to successfully reach or accomplish a goal',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'I want to achieve my career goals.',
        'She worked hard to achieve success.',
      ],
    },
    'dramatically': {
      'definition': '[adverb] in a sudden and striking way',
      'difficulty': WordDifficulty.hard,
      'examples': [
        'Prices have increased dramatically.',
        'Technology has changed dramatically over the years.',
      ],
    },
    'connected': {
      'definition': '[adjective] joined or linked together',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'We stay connected through social media.',
        'All computers are connected to the network.',
      ],
    },
    'responsibly': {
      'definition': '[adverb] in a sensible and trustworthy manner',
      'difficulty': WordDifficulty.hard,
      'examples': [
        'We should use technology responsibly.',
        'Please drive responsibly.',
      ],
    },
    'environment': {
      'definition': '[noun] the natural world and surroundings',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'We must protect the environment.',
        'Pollution harms the environment.',
      ],
    },
    'climate': {
      'definition': '[noun] the typical weather conditions in an area',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'Climate change is a global issue.',
        'The climate here is warm all year.',
      ],
    },
    'recycling': {
      'definition': '[noun] the process of converting waste into reusable material',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'Recycling helps reduce waste.',
        'Our city has a recycling program.',
      ],
    },
    'sustainable': {
      'definition': '[adjective] able to be maintained without harming the environment',
      'difficulty': WordDifficulty.hard,
      'examples': [
        'We need sustainable energy sources.',
        'Sustainable farming protects the land.',
      ],
    },
    
    // C1 Level
    'debates': {
      'definition': '[noun] formal discussions on particular topics',
      'difficulty': WordDifficulty.hard,
      'examples': [
        'Political debates help voters make decisions.',
        'The school holds debates on important issues.',
      ],
    },
    'critical': {
      'definition': '[adjective] expressing careful judgment or analysis',
      'difficulty': WordDifficulty.hard,
      'examples': [
        'Critical thinking is essential for problem-solving.',
        'She provided critical feedback on the proposal.',
      ],
    },
    'perspectives': {
      'definition': '[noun] particular ways of viewing or understanding something',
      'difficulty': WordDifficulty.hard,
      'examples': [
        'We should consider different perspectives.',
        'His perspective on the issue changed over time.',
      ],
    },
    'diverse': {
      'definition': '[adjective] showing a great deal of variety',
      'difficulty': WordDifficulty.hard,
      'examples': [
        'The city has a diverse population.',
        'We need diverse opinions in our discussion.',
      ],
    },
    'respectfully': {
      'definition': '[adverb] in a manner showing respect',
      'difficulty': WordDifficulty.hard,
      'examples': [
        'Please express your opinions respectfully.',
        'He spoke respectfully to his elders.',
      ],
    },
    'customs': {
      'definition': '[noun] traditional practices of a particular society',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'Every culture has unique customs.',
        'I learned about local customs before traveling.',
      ],
    },
    'traditions': {
      'definition': '[noun] beliefs or customs passed down through generations',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'Family traditions are important to us.',
        'They celebrate many cultural traditions.',
      ],
    },
    'globalized': {
      'definition': '[adjective] developed on a worldwide scale',
      'difficulty': WordDifficulty.hard,
      'examples': [
        'We live in a globalized economy.',
        'The world has become increasingly globalized.',
      ],
    },
    'media': {
      'definition': '[noun] the main means of mass communication',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'Social media connects people worldwide.',
        'The media reported on the election results.',
      ],
    },
    'journalists': {
      'definition': '[noun] people who write news stories',
      'difficulty': WordDifficulty.medium,
      'examples': [
        'Journalists investigate important stories.',
        'The journalists interviewed the president.',
      ],
    },
    'accurate': {
      'definition': '[adjective] correct in all details; exact',
      'difficulty': WordDifficulty.hard,
      'examples': [
        'We need accurate information before deciding.',
        'Her report was accurate and detailed.',
      ],
    },
    'unbiased': {
      'definition': '[adjective] showing no prejudice; fair and impartial',
      'difficulty': WordDifficulty.hard,
      'examples': [
        'A judge must remain unbiased.',
        'The article provided an unbiased view.',
      ],
    },
    
    // C2 Level
    'literary': {
      'definition': '[adjective] concerning the writing, study, or content of literature',
      'difficulty': WordDifficulty.hard,
      'examples': [
        'She has excellent literary skills.',
        'The book won a literary award.',
      ],
    },
    'analysis': {
      'definition': '[noun] detailed examination of elements or structure',
      'difficulty': WordDifficulty.hard,
      'examples': [
        'The analysis of the data took several weeks.',
        'Literary analysis requires deep understanding.',
      ],
    },
    'interpretation': {
      'definition': '[noun] the action of explaining the meaning of something',
      'difficulty': WordDifficulty.hard,
      'examples': [
        'Her interpretation of the poem was insightful.',
        'Different readers have different interpretations.',
      ],
    },
    'symbolism': {
      'definition': '[noun] the use of symbols to represent ideas',
      'difficulty': WordDifficulty.hard,
      'examples': [
        'The novel is rich in symbolism.',
        'Understanding symbolism enhances reading.',
      ],
    },
    'narrative': {
      'definition': '[noun] a spoken or written account of events; a story',
      'difficulty': WordDifficulty.hard,
      'examples': [
        'The narrative was compelling and well-structured.',
        'She created a powerful narrative.',
      ],
    },
    'artistry': {
      'definition': '[noun] creative skill or ability',
      'difficulty': WordDifficulty.hard,
      'examples': [
        'The artistry in this painting is remarkable.',
        'His writing shows great artistry.',
      ],
    },
  };

  // Get definition for a word
  static String? getDefinition(String word) {
    return vocabulary[word.toLowerCase()]?['definition'];
  }

  // Get examples for a word
  static List<String>? getExamples(String word) {
    return vocabulary[word.toLowerCase()]?['examples'] as List<String>?;
  }

  // Check if a word exists in vocabulary
  static bool hasWord(String word) {
    return vocabulary.containsKey(word.toLowerCase());
  }

  // Get difficulty level for a word
  static WordDifficulty? getDifficulty(String word) {
    return vocabulary[word.toLowerCase()]?['difficulty'] as WordDifficulty?;
  }

  // Get words by difficulty level
  static List<String> getWordsByDifficulty(WordDifficulty difficulty) {
    return vocabulary.entries
        .where((entry) => entry.value['difficulty'] == difficulty)
        .map((entry) => entry.key)
        .toList();
  }

  // Get highlight color based on difficulty level
  static Color getHighlightColor(String word) {
    final difficulty = getDifficulty(word);
    switch (difficulty) {
      case WordDifficulty.easy:
        return const Color(0xFFB3FFB3); // Light green
      case WordDifficulty.medium:
        return const Color(0xFFFFE5B3); // Light orange
      case WordDifficulty.hard:
        return const Color(0xFFFFB3B3); // Light red
      default:
        return const Color(0xFFFFE5B3); // Default orange
    }
  }
}
