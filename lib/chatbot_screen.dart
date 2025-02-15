import 'package:flutter/material.dart';
import 'data_loader.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  ChatbotScreenState createState() => ChatbotScreenState();
}

class ChatbotScreenState extends State<ChatbotScreen> {
  final ChatbotData chatbotData = ChatbotData();
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];

  @override
  void initState() {
    super.initState();
    _loadChatbotData();
  }

  void _loadChatbotData() async {
    await chatbotData.loadJsonData();
  }

  void sendMessage() {
    String userMessage = _controller.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      messages.add({"sender": "user", "text": userMessage});
      String response = chatbotData.getResponse(userMessage);
      messages.add({"sender": "bot", "text": response});
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chatbot Médical",
          style: TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.bold, 
            fontStyle: FontStyle.italic,
            color: const Color.fromARGB(255, 255, 255, 255),
            letterSpacing: 1.2, 
          ),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(10),
                  alignment:
                      messages[index]["sender"] == "user"
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          messages[index]["sender"] == "user"
                              ? Colors.blue[50]
                              : Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          offset: Offset(0, 2), // Shadow position
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      messages[index]["text"]!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color:
                            messages[index]["sender"] == "user"
                                ? Colors.black
                                : Colors.blueAccent,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Posez votre question...",
                      hintStyle: TextStyle(color: Colors.blueGrey),
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1),
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 2,
                        ),
                      ),
                    ),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blueAccent),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
