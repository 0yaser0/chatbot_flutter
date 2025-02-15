import 'package:flutter/material.dart';
import 'chatbot_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatbot Médical',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ChatbotScreen(),
    );
  }
}
