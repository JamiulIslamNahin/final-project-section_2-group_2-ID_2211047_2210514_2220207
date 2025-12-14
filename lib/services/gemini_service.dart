import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/chat_message.dart';

class GeminiService {
  final String apiKey;
  late final GenerativeModel model;
  late final ChatSession chat;

  GeminiService(this.apiKey) {
    model = GenerativeModel(
      model: "gemini-2.5-flash",
      apiKey: apiKey,
    );

    // Start chat session
    chat = model.startChat();
  }

  Future<String> sendMessage({
    required String message,
    required String language,
    required List<ChatMessage> history, // not used — Gemini handles its own memory
  }) async {
    try {
      final prompt =
          "You are an AI tutor for $language. Reply clearly.\nUser: $message";

      final response = await chat.sendMessage(
        Content.text(prompt),
      );

      return response.text ?? "Sorry, I couldn't generate a response.";
    } catch (e) {
      return "Error: $e";
    }
  }
}
