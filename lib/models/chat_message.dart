import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageSender {
  user,
  ai,
}

class ChatMessage {
  final String id;
  final String text;
  final MessageSender sender;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
  });

  // ---------- Convert Enum to String ----------
  String get senderToString {
    return sender == MessageSender.user ? "user" : "ai";
  }

  // ---------- Create ChatMessage Object from Firestore ----------
  factory ChatMessage.fromMap(Map<String, dynamic> map, String documentId) {
    return ChatMessage(
      id: documentId,
      text: map['text'] ?? '',
      sender: map['sender'] == "user"
          ? MessageSender.user
          : MessageSender.ai,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  // ---------- Convert To Map (For Firestore) ----------
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'sender': senderToString,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
