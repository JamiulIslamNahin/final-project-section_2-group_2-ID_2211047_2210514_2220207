import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/chat_message.dart';
import '../services/gemini_service.dart';

class ChatProvider extends ChangeNotifier {
  final String language;
  final List<ChatMessage> _messages = [];
  final _uuid = Uuid();

  bool isLoading = false;

  List<ChatMessage> get messages => _messages;

  late final GeminiService _gemini;

  ChatProvider({required this.language}) {
    _gemini = GeminiService("AIzaSyBl0CMgO_oM4DAmwmLwogFmk82kW1yHRk0");
    generateWelcomeMessage();
  }

  void generateWelcomeMessage() {
    _messages.add(
      ChatMessage(
        id: _uuid.v4(),
        sender: MessageSender.ai,
        text:
        "Hello! I'm your AI tutor for $language.\nLet's start practicing! How can I help you today?",
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  Future<void> sendUserMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMsg = ChatMessage(
      id: _uuid.v4(),
      text: text,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );

    _messages.add(userMsg);
    notifyListeners();

    isLoading = true;
    notifyListeners();

    final reply = await _gemini.sendMessage(
      message: text,
      language: language,
      history: _messages,
    );

    _messages.add(
      ChatMessage(
        id: _uuid.v4(),
        text: reply,
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
      ),
    );

    isLoading = false;
    notifyListeners();
  }
}
