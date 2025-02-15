import 'dart:convert';
import 'package:flutter/services.dart';

class ChatbotData {
  List<Map<String, dynamic>> intents = [];

  Future<void> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/medical_data.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    intents = List<Map<String, dynamic>>.from(jsonData["intents"]);
  }

  String getResponse(String userMessage) {
    for (var intent in intents) {
      for (var question in intent["questions"]) {
        if (userMessage.toLowerCase() == question.toLowerCase()) {
          return intent["responses"][0];
        }
      }
    }
    return "Désolé, je n'ai pas compris votre question.";
  }
}
