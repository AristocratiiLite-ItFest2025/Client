class ChatModel {
  final int id;
  final String title;
  final String? imageUrl;
  final String? lastMessage;
  final DateTime? lastMessageTimestamp;

  ChatModel({
    required this.id,
    required this.title,
    this.lastMessage,
    this.lastMessageTimestamp,
    this.imageUrl,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] as int,
      title: json['name'] as String, // Using "name" from JSON
      lastMessage: json['last_message'] as String?, // Using "last_message"
      lastMessageTimestamp: json.containsKey('last_message_timestamp') && json['last_message_timestamp'] != null
          ? DateTime.parse(json['last_message_timestamp'])
          : null, // It might be null if not provided.
      imageUrl: json['chat_image'] as String?, // Using "chat_image"
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title, // matching the API key
      'last_message': lastMessage,
      'last_message_timestamp': lastMessageTimestamp?.toIso8601String(),
      'chat_image': imageUrl,
    };
  }
}
