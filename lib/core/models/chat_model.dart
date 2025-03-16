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
      title: json['title'] as String,
      lastMessage: json['lastMessage'] as String?,
      lastMessageTimestamp: json['lastMessageTimestamp'] != null
          ? DateTime.parse(json['lastMessageTimestamp'])
          : null,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'lastMessage': lastMessage,
      'lastMessageTimestamp':
      lastMessageTimestamp?.toIso8601String(),
      'imageUrl': imageUrl,
    };
  }
}
