import 'package:intl/intl.dart';

class EntryModel {
  final int id;
  final int chatId;
  final int userId;
  final DateTime timestamp;
  final String text;

  EntryModel({
    required this.id,
    required this.chatId,
    required this.userId,
    required this.timestamp,
    required this.text,
  });

  factory EntryModel.fromJson(Map<String, dynamic> json) {
    final dateFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'");
    return EntryModel(
      id: json['id'] as int,
      chatId: json['chat_id'] as int,
      userId: json['user_id'] as int,
      timestamp: dateFormat.parseUtc(json['timestamp'] as String),
      text: json['text'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'");
    return {
      'id': id,
      'chat_id': chatId,
      'user_id': userId,
      'timestamp': dateFormat.format(timestamp.toUtc()),
      'text': text,
    };
  }
}
