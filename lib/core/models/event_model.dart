class EventModel {
  final int id;
  final int authorId;
  final String name;
  final String description;
  final String? image;
  final String? iconImage;
  final DateTime startTime;
  final DateTime endTime;
  final List<int> attendees;
  final int attendeesCount;
  final String? recurringDuration;
  final String emailForContact;
  final String phoneContact;
  final double lat;
  final double lon;

  EventModel({
    required this.id,
    required this.authorId,
    required this.name,
    required this.description,
    this.image,
    this.iconImage,
    required this.startTime,
    required this.endTime,
    required this.attendees,
    required this.attendeesCount,
    this.recurringDuration,
    required this.emailForContact,
    required this.phoneContact,
    required this.lat,
    required this.lon,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      authorId: json['author_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'], // Nullable
      iconImage: json['icon_image'], // Nullable
      startTime: DateTime.parse(json['start_time']).toUtc(),
      endTime: DateTime.parse(json['end_time']).toUtc(),
      attendees: List<int>.from(json['attendees']), // Converts List<dynamic> to List<int>
      attendeesCount: json['attendees_count'],
      recurringDuration: json['recurring_duration'], // Nullable
      emailForContact: json['email_for_contact'],
      phoneContact: json['phone_contact'],
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author_id': authorId,
      'name': name,
      'description': description,
      'image': image ?? null,
      'icon_image': iconImage ?? null,
      'start_time': startTime.toUtc().toIso8601String(),
      'end_time': endTime.toUtc().toIso8601String(),
      'attendees': attendees.isNotEmpty ? attendees : [],
      'recurring_duration': recurringDuration,
      'email_for_contact': emailForContact,
      'phone_contact': phoneContact,
      'lat': lat,
      'lon': lon,
    };
  }
}
