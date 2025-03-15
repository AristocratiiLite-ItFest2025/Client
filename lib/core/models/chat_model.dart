class ChatModel {
  final int id;
  final String title;
  final String lastMessage;
  final DateTime lastMessageTimestamp;
  final String? imageUrl;

  ChatModel({
    required this.id,
    required this.title,
    required this.lastMessage,
    required this.lastMessageTimestamp,
    this.imageUrl,
  });
}