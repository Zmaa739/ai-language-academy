import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق وائل',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أكاديمية لغات الذكاء الاصطناعي'),
      ),
      body: const Center(
        child: Text(
          'مرحباً بك يا وائل، التطبيق يعمل بنجاح!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
