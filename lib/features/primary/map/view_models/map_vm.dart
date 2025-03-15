import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/models/event_model.dart';
import '../../../../core/services/map_service.dart';

class MapState {
  final LatLng center;
  final double zoom;
  final List<Event> events;

  MapState({
    required this.center,
    required this.zoom,
    required this.events,
  });

  MapState copyWith({
    LatLng? center,
    double? zoom,
    List<Event>? events,
  }) {
    return MapState(
      center: center ?? this.center,
      zoom: zoom ?? this.zoom,
      events: events ?? this.events,
    );
  }
}

class MapViewModel extends StateNotifier<MapState> {
  final MapService _mapService;

  MapViewModel(this._mapService)
      : super(
    MapState(
      center: const LatLng(45.7489, 21.2087),
      zoom: 13,
      events: [
        Event(
          imageUrl: null,
          organizer: 'MusicFest Org',
          dateTime: '2025-03-22 20:00',
          description:
          'Enjoy live music at the heart of Timisoara during our annual music festival.',
          // 5.55 km north of center
          location: const LatLng(45.7989, 21.2087),
        ),
        Event(
          imageUrl: null,
          organizer: 'ArtCulture',
          dateTime: '2025-03-25 16:00',
          description:
          'Experience local art and creativity at the cultural center.',
          // 7 km east of center
          location: const LatLng(45.7489, 21.2987),
        ),
        Event(
          imageUrl: null,
          organizer: 'Foodies United',
          dateTime: '2025-03-26 12:00',
          description:
          'Taste the flavors of Timisoara at our food tasting festival.',
          // 5.55 km south-west (approx.)
          location: const LatLng(45.6989, 21.1787),
        ),
        Event(
          imageUrl: null,
          organizer: 'Tech Innovators',
          dateTime: '2025-03-27 18:30',
          description:
          'Join the tech meetup to network with industry leaders.',
          // Slightly north, 6.22 km west of center
          location: const LatLng(45.7689, 21.1287),
        ),
        Event(
          imageUrl: null,
          organizer: 'Cinema Under Stars',
          dateTime: '2025-03-28 21:00',
          description:
          'Enjoy an outdoor cinema night featuring classic films.',
          // 5.55 km north and 3.11 km east
          location: const LatLng(45.7989, 21.2487),
        ),
        Event(
          imageUrl: null,
          organizer: 'History Walks',
          dateTime: '2025-03-29 10:00',
          description:
          'Discover the rich history of Timisoara on a guided walking tour.',
          // 4.44 km south and 4.66 km west
          location: const LatLng(45.7089, 21.1487),
        ),
        Event(
          imageUrl: null,
          organizer: 'Jazz Vibes',
          dateTime: '2025-03-30 19:30',
          description:
          'Relax with smooth jazz tunes at our local jazz night event.',
          // 4.44 km north-west (approx.)
          location: const LatLng(45.7889, 21.1487),
        ),
        Event(
          imageUrl: null,
          organizer: 'Startup Hub',
          dateTime: '2025-04-01 17:00',
          description:
          'Pitch your startup idea and connect with investors.',
          // 2.22 km north and 7 km east of center
          location: const LatLng(45.7689, 21.2987),
        ),
        Event(
          imageUrl: null,
          organizer: 'Poetry Circle',
          dateTime: '2025-04-02 20:00',
          description:
          'Share your poetic expressions at our community poetry slam.',
          // 4.44 km south and 3.89 km east
          location: const LatLng(45.7089, 21.2587),
        ),
        Event(
          imageUrl: null,
          organizer: 'Book Lovers',
          dateTime: '2025-04-03 09:00',
          description:
          'Explore a variety of books at the annual book fair.',
          // 5.55 km north and 3.11 km east
          location: const LatLng(45.7989, 21.2487),
        ),
        Event(
          imageUrl: null,
          organizer: 'Street Art Crew',
          dateTime: '2025-04-04 11:00',
          description:
          'Discover vibrant street art on a guided tour of the city.',
          // 5.55 km south-west (approx.)
          location: const LatLng(45.6989, 21.1587),
        ),
        Event(
          imageUrl: null,
          organizer: 'Charity Run Org',
          dateTime: '2025-04-05 07:30',
          description:
          'Participate in a charity run to support local communities.',
          // 5.55 km north-west and 4.66 km west (approx.)
          location: const LatLng(45.7989, 21.1487),
        ),
        Event(
          imageUrl: null,
          organizer: 'Wine Enthusiasts',
          dateTime: '2025-04-06 18:00',
          description:
          'Taste exquisite wines at an evening wine tasting event.',
          // 6.66 km south and a slight west offset
          location: const LatLng(45.6889, 21.1887),
        ),
        Event(
          imageUrl: null,
          organizer: 'Theater Arts',
          dateTime: '2025-04-07 19:00',
          description:
          'Enjoy a captivating local theater performance.',
          // 7 km east of center
          location: const LatLng(45.7489, 21.2987),
        ),
        Event(
          imageUrl: null,
          organizer: 'PhotoWorkshop Inc.',
          dateTime: '2025-04-08 15:00',
          description:
          'Enhance your photography skills in a hands-on workshop.',
          // 5.55 km north and 1.55 km east (approx.)
          location: const LatLng(45.7989, 21.2287),
        ),
        Event(
          imageUrl: null,
          organizer: 'Wellness Retreats',
          dateTime: '2025-04-09 08:00',
          description:
          'Join us for a rejuvenating meditation and yoga retreat.',
          // 5.55 km south-west (approx.)
          location: const LatLng(45.6989, 21.1587),
        ),
        Event(
          imageUrl: null,
          organizer: 'Culinary Arts',
          dateTime: '2025-04-10 14:00',
          description:
          'Learn traditional Romanian recipes in our cooking class.',
          // 3.33 km north and 5.44 km east (approx.)
          location: const LatLng(45.7789, 21.2787),
        ),
        Event(
          imageUrl: null,
          organizer: 'Fashion Forward',
          dateTime: '2025-04-11 17:00',
          description:
          'Explore the latest trends at our pop-up fashion event.',
          // 3.33 km south and 6.22 km east (approx.)
          location: const LatLng(45.7189, 21.2887),
        ),
        Event(
          imageUrl: null,
          organizer: 'Cycle Timisoara',
          dateTime: '2025-04-12 08:30',
          description:
          'Join a scenic cycling tour around the city’s landmarks.',
          // 5.55 km north and 4.66 km west (approx.)
          location: const LatLng(45.7989, 21.1487),
        ),
        Event(
          imageUrl: null,
          organizer: 'FilmFest',
          dateTime: '2025-04-13 20:30',
          description:
          'Experience premieres and screenings at the film festival.',
          // Adjusted to 3.33 km north and 6.22 km east (approx.)
          location: const LatLng(45.7789, 21.2887),
        ),
      ],
    ),
  );

  Future<void> loadCurrentLocation() async {
    final currentLocation = await _mapService.getCurrentLocation();
    state = state.copyWith(center: currentLocation);
  }
}

final mapViewModelProvider =
StateNotifierProvider<MapViewModel, MapState>((ref) {
  final mapService = MapService();
  return MapViewModel(mapService);
});
