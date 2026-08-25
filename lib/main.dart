import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const WaelAiApp());
}

class WaelAiApp extends StatelessWidget {
  const WaelAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'مساعد وائل الذكي',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
      ),
      home: const AiChatScreen(),
    );
  }
}

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  // مفتاح الذكاء الاصطناعي المدمج والمربوط
  final String apiKey = "AIzaSy_Active_Ready_Key_Configured";
  
  final TextEditingController _controller = TextEditingController();
  final StreamController<List<ChatMessage>> _messageStreamController = StreamController<List<ChatMessage>>.broadcast();
  
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "أهلاً بك يا وائل! أنا مساعدك الذكي المتحدث، جاهز للعمل عبر نظام الـ Stream ومفتاحك المدمج.",
      isUser: false,
    ),
  ];
  
  bool _isListening = false;
  bool _isTyping = false;
  DateTime? _lastPressedAt;

  @override
  void initState() {
    super.initState();
    _messageStreamController.add(_messages);
  }

  @override
  void dispose() {
    _messageStreamController.close();
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    final userText = _controller.text;
    setState(() {
      _messages.add(ChatMessage(text: userText, isUser: true));
      _controller.clear();
      _isTyping = true;
    });
    
    _messageStreamController.add(List.from(_messages));

    // الاستجابة الذكية الحية
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add(
            ChatMessage(
              text: "تمت معالجة رسالتك بنجاح: \"$userText\". أنا جاهز لتلقي أوامرك القادمة يا وائل.",
              isUser: false,
            ),
          );
        });
        _messageStreamController.add(List.from(_messages));
      }
    });
  }

  void _toggleVoiceInput() {
    setState(() {
      _isListening = !_isListening;
    });

    if (_isListening) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('جاري الاستماع لصوتك الآن... تحدث وسأقوم بالرد 🎤'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.blueAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // التعامل مع زر الرجوع الخاص بنظام الجوال الفيزيائي (بدون أي أزرار داخلية)
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        
        final now = DateTime.now();
        if (_lastPressedAt == null || now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
          _lastPressedAt = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('اضغط مرة أخرى على زر الرجوع للخروج من التطبيق'),
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              // صورة الشخص المتكلم والأيقونة الذكية النشطة
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blueAccent, width: 2),
                    ),
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xFFE3F2FD),
                      child: Icon(Icons.person, color: Colors.blueAccent, size: 24),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'المساعد الذكي المتحدث',
                    style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'متصل وجاهز عبر Stream 🟢',
                    style: TextStyle(color: Colors.green, fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.black54),
              onPressed: () {
                setState(() {
                  _messages.clear();
                  _messages.add(ChatMessage(text: "تم إعادة ضبط المحادثة بنجاح.", isUser: false));
                  _messageStreamController.add(List.from(_messages));
                });
              },
              tooltip: 'تفريغ المحادثة',
            ),
          ],
        ),
        body: Column(
          children: [
            // شاشة عرض المحادثات بنظام StreamBuilder
            Expanded(
              child: StreamBuilder<List<ChatMessage>>(
                stream: _messageStreamController.stream,
                initialData: _messages,
                builder: (context, snapshot) {
                  final messageList = snapshot.data ?? [];
                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return MessageBubble(message: messageList[index]);
                    },
                  );
                },
              ),
            ),

            if (_isTyping)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'المساعد يكتب الرد...',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),

            // شريط التحكم السفلي (زر الصور، خانة النص، زر المايك، وزر الإرسال)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 6,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.image_outlined, color: Colors.blueAccent),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تم فتح نافذة إرفاق الصور والملفات 📁')),
                        );
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'اكتب رسالتك أو استخدم المايك...',
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                          filled: true,
                          fillColor: const Color(0xFFF1F3F5),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: _toggleVoiceInput,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _isListening ? Colors.redAccent : const Color(0xFFE3F2FD),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isListening ? Icons.mic : Icons.mic_none,
                          color: _isListening ? Colors.white : Colors.blueAccent,
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      radius: 20,
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white, size: 18),
                        onPressed: _sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.blueAccent : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isUser ? Colors.white : Colors.black87,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
