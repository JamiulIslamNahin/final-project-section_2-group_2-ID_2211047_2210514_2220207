import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_message.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save a message under a language chat session
  Future<void> saveMessage(
      String language, ChatMessage message) async {
    await _db
        .collection("language_chats")
        .doc(language)
        .collection("messages")
        .add(message.toMap());
  }

  // Load all messages for selected language
  Stream<List<ChatMessage>> loadMessages(String language) {
    return _db
        .collection("language_chats")
        .doc(language)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => ChatMessage.fromMap(doc.data(), doc.id))
        .toList());
  }

  // Clear chat for selected language
  Future<void> clearChat(String language) async {
    final messages = await _db
        .collection("language_chats")
        .doc(language)
        .collection("messages")
        .get();

    for (var doc in messages.docs) {
      await doc.reference.delete();
    }
  }
}
