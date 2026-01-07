import '../models/article.dart';
import '../models/tier.dart';

final dummyArticles = [
  Article(
    id: 'a1-001',
    tier: Tier.A1,
    title: 'My First Words',
    summary:
        'Learn basic words and greetings in English. Practice common phrases for everyday conversations.',
    content:
        'Hello! My name is Sarah. I like to read books every day. I say hello to my friends at school. Learning new words helps me talk better.',
  ),
  Article(
    id: 'a1-002',
    tier: Tier.A1,
    title: 'Numbers and Colors',
    summary:
        'Learn how to count and describe colors in English. Essential vocabulary for beginners.',
    content:
        'I can count from one to ten. My favorite color is blue. The sky is blue and the grass is green. I see many colors around me every day.',
  ),
  Article(
    id: 'a1-003',
    tier: Tier.A1,
    title: 'My Family',
    summary:
        'Talk about your family members in English. Learn vocabulary for describing relatives.',
    content:
        'I have a small family. My mother and father are very kind. I have one brother. We play together in the park. I love my family very much.',
  ),
  Article(
    id: 'a2-001',
    tier: Tier.A2,
    title: 'My Favorite Hobby',
    summary:
        'Learn how to talk about hobbies and free-time activities in English. Practice vocabulary for daily routines and interests.',
    content:
        'My favorite hobby is reading books. I like to read every day after school. My favorite books are adventure stories because they are exciting and fun. I usually read for one hour in the evening. Sometimes, I also read with my friends and talk about the story. Reading helps me learn new words and improve my English.',
  ),
  Article(
    id: 'a2-002',
    tier: Tier.A2,
    title: 'A Day at the Park',
    summary:
        'Learn how to talk about daily activities and outdoor routines in English. Practice vocabulary for places, actions, and simple sentences.',
    content:
        'Yesterday I went to the park with my family. The park has many trees and flowers. We had a picnic and played games. I saw children playing and dogs running. It was an exciting day. The weather was sunny and warm. I want to go back to the park next weekend.',
  ),
  Article(
    id: 'a2-003',
    tier: Tier.A2,
    title: 'My Favorite Food',
    summary:
        'Learn how to describe food and meals in English. Practice vocabulary for tastes, ingredients, and expressing likes and dislikes.',
    content:
        'I love pizza! Pizza is my favorite food. It has cheese, tomato sauce, and many toppings. I like to eat pizza with my family on weekends. Sometimes we make pizza at home. It tastes delicious! I also enjoy eating ice cream for dessert.',
  ),
  Article(
    id: 'b1-001',
    tier: Tier.B1,
    title: 'Travel Adventures',
    summary:
        'Talk about travel experiences and destinations. Practice vocabulary for planning trips.',
    content:
        'Last summer, I went on an exciting adventure to the mountains. The journey was long but beautiful. I saw amazing landscapes with tall peaks and green valleys. I took many photos and met interesting people. Traveling helps me learn about different cultures and improve my language skills. I want to visit more countries in the future.',
  ),
  Article(
    id: 'b1-002',
    tier: Tier.B1,
    title: 'Shopping Experience',
    summary:
        'Learn vocabulary for shopping and making purchases. Practice conversations in stores.',
    content:
        'Shopping for clothes is one of my hobbies. I enjoy visiting different stores and trying new styles. Last week, I bought a blue jacket and a pair of shoes. The shopkeeper was very helpful and friendly. I always compare prices before buying something. Shopping helps me practice speaking English with store staff.',
  ),
  Article(
    id: 'b1-003',
    tier: Tier.B1,
    title: 'Health and Fitness',
    summary:
        'Discuss health topics and fitness routines. Learn medical vocabulary.',
    content:
        'Staying healthy is important to me. I exercise three times a week at the gym. I also try to eat healthy food like fruits and vegetables. Drinking water and getting enough sleep help me feel energetic. Regular exercise helps improve my strength and keeps me fit. A healthy lifestyle makes me happy.',
  ),
  Article(
    id: 'b2-001',
    tier: Tier.B2,
    title: 'Work and Career',
    summary:
        'Describe jobs and workplace vocabulary. Learn professional English for career development.',
    content:
        'Choosing a career is an important decision. I am interested in working in technology because it is exciting and always changing. I want to improve my skills and learn new things. Professional development helps people advance in their careers. Good communication skills are essential for success in any job. I am working hard to achieve my career goals.',
  ),
  Article(
    id: 'b2-002',
    tier: Tier.B2,
    title: 'Technology Today',
    summary:
        'Discuss modern technology and its impact. Learn tech-related vocabulary.',
    content:
        'Technology has changed our lives dramatically. We use smartphones, computers, and the internet every day. These tools help us work faster and stay connected with friends. However, we need to be careful about spending too much time on screens. Technology can improve our lives, but we should use it wisely and responsibly.',
  ),
  Article(
    id: 'b2-003',
    tier: Tier.B2,
    title: 'Environmental Issues',
    summary:
        'Talk about the environment and sustainability. Learn vocabulary for discussing climate.',
    content:
        'Protecting the environment is everyone\'s responsibility. Climate change is an exciting challenge that we must address. We can help by reducing waste, recycling, and using less energy. Planting trees and protecting wildlife are also important. Small changes in our daily habits can improve our planet. We need to work together for a sustainable future.',
  ),
  Article(
    id: 'c1-001',
    tier: Tier.C1,
    title: 'Debates and Opinions',
    summary:
        'Expressing nuanced opinions and arguments. Learn advanced discussion techniques.',
    content:
        'Engaging in debates requires critical thinking and clear communication. When presenting arguments, it is important to consider different perspectives. Reading diverse books and articles helps improve our understanding of complex issues. We should express our opinions respectfully while being open to other viewpoints. Effective debating is an exciting skill that develops through practice.',
  ),
  Article(
    id: 'c1-002',
    tier: Tier.C1,
    title: 'Cultural Differences',
    summary:
        'Analyze cultural perspectives and social norms. Discuss cross-cultural communication.',
    content:
        'Understanding cultural differences is essential in our globalized world. Different societies have unique customs, traditions, and ways of communication. Reading about other cultures through books and articles helps us appreciate diversity. Cross-cultural experiences can be exciting and enriching. Learning about cultures helps improve our ability to connect with people worldwide.',
  ),
  Article(
    id: 'c1-003',
    tier: Tier.C1,
    title: 'Media and Influence',
    summary:
        'Examine media\'s role in society. Discuss journalism and information spread.',
    content:
        'The media plays a crucial role in shaping public opinion. Journalists have a responsibility to report accurate and unbiased information. Reading various news sources helps us develop critical thinking. The exciting world of digital media has transformed how we consume information. We must improve our media literacy to distinguish between facts and opinions.',
  ),
  Article(
    id: 'c2-001',
    tier: Tier.C2,
    title: 'Literature Analysis',
    summary:
        'Analyze texts and infer deeper meanings. Master literary criticism techniques.',
    content:
        'Literary analysis requires deep reading and critical interpretation. When examining books and texts, we explore themes, symbolism, and narrative techniques. Classic literature offers exciting insights into human nature and society. Through careful reading and analysis, we can improve our understanding of complex literary works and appreciate the artistry of great authors.',
  ),
  Article(
    id: 'c2-002',
    tier: Tier.C2,
    title: 'Philosophy and Ethics',
    summary:
        'Discuss complex philosophical concepts. Debate ethical dilemmas.',
    content:
        'Philosophy explores fundamental questions about existence, knowledge, and morality. Reading philosophical texts challenges us to think deeply about ethics and human values. Engaging with these exciting ideas helps improve our reasoning abilities. Philosophical inquiry encourages us to question assumptions and develop well-reasoned arguments about complex moral issues.',
  ),
  Article(
    id: 'c2-003',
    tier: Tier.C2,
    title: 'Academic Writing',
    summary:
        'Master formal academic writing styles. Learn research and citation techniques.',
    content:
        'Academic writing demands precision, clarity, and rigorous research. Reading scholarly books and articles is essential for understanding academic conventions. Proper citation and referencing are crucial to avoid plagiarism. Developing these skills requires practice and dedication. The exciting journey of academic writing helps improve our ability to communicate complex ideas effectively and persuasively.',
  ),
];
