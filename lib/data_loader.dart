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
      for (int i = 0; i < intent["questions"].length; i++) {
        if (userMessage.toLowerCase() == intent["questions"][i].toLowerCase()) {
          return intent["responses"][i]; 
        }
      }
    }
    return "Désolé, je n'ai pas compris votre question.";
  }
}

