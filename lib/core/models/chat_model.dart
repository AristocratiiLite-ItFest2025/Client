class Chat {
  final String title;
  final String lastMessage;
  final DateTime lastMessageTimestamp;
  final String? imageUrl;

  Chat({
    required this.title,
    required this.lastMessage,
    required this.lastMessageTimestamp,
    this.imageUrl,
  });
}