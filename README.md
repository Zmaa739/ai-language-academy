import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

const String geminiApiKey = 'AQ.Ab8RN6JO9b5BsWaNzxhb_yqGlRX1bHYalKJhM2EHnHujyS0SEw.';

void main() {
  runApp(const MyAIApp());
}

class MyAIApp extends StatelessWidget {
  const MyAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Language Academy',
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        primaryColor: const Color(0xFF2563EB),
      ),
      home: const RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("مرحباً بك! 👋", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("أنشئ حسابك للبدء في تعلم اللغات بالذكاء الاصطناعي", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "البريد الإلكتروني",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "كلمة المرور",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LanguageSelectionScreen()),
                      );
                    }
                  },
                  child: const Text("متابعة", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String nativeLanguage = 'العربية';
  String targetLanguage = 'الإنجليزيّة';
  final List<String> languages = ['العربية', 'الإنجليزيّة', 'الفرنسية', 'الإسبانية', 'الألمانية', 'الصينية'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text("إعداد اللغات", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              const Text("لغتك الأم:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: nativeLanguage,
                items: languages.map((lang) => DropdownMenuItem(value: lang, child: Text(lang))).toList(),
                onChanged: (val) => setState(() => nativeLanguage = val!),
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
              ),
              const SizedBox(height: 24),
              const Text("اللغة التي تريد تعلمها:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: targetLanguage,
                items: languages.map((lang) => DropdownMenuItem(value: lang, child: Text(lang))).toList(),
                onChanged: (val) => setState(() => targetLanguage = val!),
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const MainTabWrapper()),
                    );
                  },
                  child: const Text("ابدأ التعلم الآن 🚀", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainTabWrapper extends StatefulWidget {
  const MainTabWrapper({super.key});

  @override
  State<MainTabWrapper> createState() => _MainTabWrapperState();
}

class _MainTabWrapperState extends State<MainTabWrapper> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const RoleplayScreen(),
    const ProgressScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.theater_comedy), label: 'تمثيل الأدوار'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'المستوى'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الملف الشخصي'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF1E293B),
              child: Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SubscriptionScreen()));
                    },
                    icon: const Icon(Icons.star, color: Colors.amber, size: 18),
                    label: const Text('PRO', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white12),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatLessonScreen()));
                    },
                    icon: const Icon(Icons.chat, color: Colors.white),
                    label: const Text('دردشة حرة', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: [
                  const Center(child: Text("المسار التعليمي", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey))),
                  const SizedBox(height: 20),
                  _buildPathNode(context, 'Daily Habits', Icons.fitness_center, Colors.orange),
                  _buildPathNode(context, 'Everyday Things', Icons.book, Colors.purple),
                  _buildPathNode(context, 'Free Time', Icons.access_time, Colors.deepOrange),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPathNode(BuildContext context, String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatLessonScreen())),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            CircleAvatar(radius: 40, backgroundColor: color, child: Icon(icon, size: 35, color: Colors.white)),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close, size: 28, color: Colors.grey),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 10),
              const Text("ترقية للحساب المميز PRO 🌟", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("احصل على الوصول الكامل بدون إعلانات وبسرعة فائقة", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),
              _buildPlanCard(context, "باقة 10 أيام", "5 ريال سعودي", "تجربة سريعة للوصول الكامل", Colors.blue),
              const SizedBox(height: 12),
              _buildPlanCard(context, "الباقة الشهرية", "10 ريال سعودي", "اشتراك شهر كامل مع المعلم الذكي", Colors.green),
              const SizedBox(height: 12),
              _buildPlanCard(context, "الباقة السنوية", "100 ريال سعودي", "توفير ضخم وااشتراك طوال السنة", Colors.orange),
              const Spacer(),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("المتابعة بالنسخة المجانية مع الإعلانات", style: TextStyle(color: Colors.grey, decoration: TextDecoration.underline)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, String title, String price, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
              const SizedBox(height: 4),
              Text(desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          Text(price, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}

class ChatLessonScreen extends StatefulWidget {
  const ChatLessonScreen({super.key});

  @override
  State<ChatLessonScreen> createState() => _ChatLessonScreenState();
}

class _ChatLessonScreenState extends State<ChatLessonScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;
  GenerativeModel? _model;

  @override
  void initState() {
    super.initState();
    if (geminiApiKey.isNotEmpty) {
      _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: geminiApiKey);
    }
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    if (_model == null) {
      setState(() {
        _messages.add({'sender': 'ai', 'text': 'تنبيه: يرجى كتابة مفتاح API.'});
      });
      return;
    }

    setState(() {
      _messages.add({'sender': 'user', 'text': text});
      _isLoading = true;
    });
    _textController.clear();

    try {
      final prompt = "أنت معلم لغات تفاعلي. صحح أخطاء الجملة التالية: $text";
      final response = await _model!.generateContent([Content.text(prompt)]);
      setState(() {
        _messages.add({'sender': 'ai', 'text': response.text ?? 'رد فارغ'});
      });
    } catch (e) {
      setState(() {
        _messages.add({'sender': 'ai', 'text': 'حدث خطأ في الاتصال.'});
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المعلم الذكي'), backgroundColor: const Color(0xFF1E293B)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['sender'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isUser ? const Color(0xFFDBEAFE) : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(msg['text']!, style: TextStyle(fontSize: 16)),
                  ),
                );
              },
            ),
          ),
          if (_isLoading) const LinearProgressIndicator(),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(hintText: 'اكتب رسالتك...', border: InputBorder.none),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF2563EB)),
                  onPressed: () => _sendMessage(_textController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RoleplayScreen extends StatelessWidget {
  const RoleplayScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تمثيل الأدوار')),
      body: const Center(child: Text("اختر سيناريو المحادثة")),
    );
  }
}

class ProgressScreen({super.key});

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المستوى والتقدم')),
      body: const Center(child: Text("إحصائيات التقدم التعليمي")),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الملف الشخصي')),
      body: const Center(child: Text("إعدادات الحساب واللغات")),
    );
  }
}
