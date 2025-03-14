class Event {
  final String? imageUrl;
  final String organizer;
  final String dateTime;
  final String description;

  Event({
    this.imageUrl,
    required this.organizer,
    required this.dateTime,
    required this.description,
  });
}
