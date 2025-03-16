import 'package:intl/intl.dart';

class EventModel {
  final int id;
  final int authorId;
  final String name;
  final String description;
  final String image;
  final String iconImage;
  final DateTime startTime;
  final DateTime endTime;
  final int attendees;
  final String recurringDuration;
  final String emailForContact;
  final String phoneContact;
  final double lat;
  final double lon;

  EventModel({
    required this.id,
    required this.authorId,
    required this.name,
    required this.description,
    required this.image,
    required this.iconImage,
    required this.startTime,
    required this.endTime,
    required this.attendees,
    required this.recurringDuration,
    required this.emailForContact,
    required this.phoneContact,
    required this.lat,
    required this.lon,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    final dateFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'");
    return EventModel(
      id: json['id'],
      authorId: json['author_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      iconImage: json['icon_image'],
      startTime: dateFormat.parseUtc(json['start_time']),
      endTime: dateFormat.parseUtc(json['end_time']),
      attendees: json['attendees'],
      recurringDuration: json['recurring_duration'],
      emailForContact: json['email_for_contact'],
      phoneContact: json['phone_contact'],
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );
  }
}
