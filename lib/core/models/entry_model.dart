class EntryModel {
  final int chatId;
  final String message;
  final bool isMine;
  final DateTime timestamp;

  EntryModel({
    required this.chatId,
    required this.message,
    required this.isMine,
    required this.timestamp,
  });
}