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
    return EntryModel(
      id: json['id'] as int,
      chatId: json['chat_id'] as int,
      userId: json['user_id'] as int,
      timestamp: DateTime.parse(json['timestamp'] as String).toUtc(), // Fixed key
      text: json['text'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chat_id': chatId,
      'user_id': userId,
      'timestamp': timestamp.toUtc().toIso8601String(),
      'text': text,
    };
  }
}
