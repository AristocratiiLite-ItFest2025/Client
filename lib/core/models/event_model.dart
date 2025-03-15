import 'package:latlong2/latlong.dart';

class Event {
  final String? imageUrl;
  final String organizer;
  final String dateTime;
  final String description;
  final LatLng location;

  Event({
    this.imageUrl,
    required this.organizer,
    required this.dateTime,
    required this.description,
    required this.location,
  });
}
