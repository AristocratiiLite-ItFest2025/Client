import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/models/event_model.dart';

/// The view model for our event list.
/// Here we use a StateNotifier to manage a list of events.
class EventListVM extends StateNotifier<List<Event>> {
  EventListVM() : super(_mockEvents);

// Additional methods to modify or fetch events can be added here.
}

/// Provider exposing the EventViewModel.
final eventViewModelProvider =
StateNotifierProvider<EventListVM, List<Event>>((ref) {
  return EventListVM();
});

/// Some mock events for demonstration.
final List<Event> _mockEvents = [
  Event(
    imageUrl: null,
    organizer: 'MusicFest Org',
    dateTime: '2025-03-22 20:00',
    description: 'Enjoy live music at the heart of Timisoara during our annual music festival.',
    location: const LatLng(45.7501, 21.2095),
  ),
  Event(
    imageUrl: null,
    organizer: 'ArtCulture',
    dateTime: '2025-03-25 16:00',
    description: 'Experience local art and creativity at the cultural center.',
    location: const LatLng(45.7485, 21.2102),
  ),
  Event(
    imageUrl: null,
    organizer: 'Foodies United',
    dateTime: '2025-03-26 12:00',
    description: 'Taste the flavors of Timisoara at our food tasting festival.',
    location: const LatLng(45.7492, 21.2078),
  ),
  Event(
    imageUrl: null,
    organizer: 'Tech Innovators',
    dateTime: '2025-03-27 18:30',
    description: 'Join the tech meetup to network with industry leaders.',
    location: const LatLng(45.7478, 21.2099),
  ),
  Event(
    imageUrl: null,
    organizer: 'Cinema Under Stars',
    dateTime: '2025-03-28 21:00',
    description: 'Enjoy an outdoor cinema night featuring classic films.',
    location: const LatLng(45.7489, 21.2110),
  ),
  Event(
    imageUrl: null,
    organizer: 'History Walks',
    dateTime: '2025-03-29 10:00',
    description: 'Discover the rich history of Timisoara on a guided walking tour.',
    location: const LatLng(45.7495, 21.2080),
  ),
  Event(
    imageUrl: null,
    organizer: 'Jazz Vibes',
    dateTime: '2025-03-30 19:30',
    description: 'Relax with smooth jazz tunes at our local jazz night event.',
    location: const LatLng(45.7480, 21.2105),
  ),
  Event(
    imageUrl: null,
    organizer: 'Startup Hub',
    dateTime: '2025-04-01 17:00',
    description: 'Pitch your startup idea and connect with investors.',
    location: const LatLng(45.7490, 21.2092),
  ),
  Event(
    imageUrl: null,
    organizer: 'Poetry Circle',
    dateTime: '2025-04-02 20:00',
    description: 'Share your poetic expressions at our community poetry slam.',
    location: const LatLng(45.7483, 21.2108),
  ),
  Event(
    imageUrl: null,
    organizer: 'Book Lovers',
    dateTime: '2025-04-03 09:00',
    description: 'Explore a variety of books at the annual book fair.',
    location: const LatLng(45.7493, 21.2075),
  ),
  Event(
    imageUrl: null,
    organizer: 'Street Art Crew',
    dateTime: '2025-04-04 11:00',
    description: 'Discover vibrant street art on a guided tour of the city.',
    location: const LatLng(45.7487, 21.2112),
  ),
  Event(
    imageUrl: null,
    organizer: 'Charity Run Org',
    dateTime: '2025-04-05 07:30',
    description: 'Participate in a charity run to support local communities.',
    location: const LatLng(45.7479, 21.2090),
  ),
  Event(
    imageUrl: null,
    organizer: 'Wine Enthusiasts',
    dateTime: '2025-04-06 18:00',
    description: 'Taste exquisite wines at an evening wine tasting event.',
    location: const LatLng(45.7494, 21.2085),
  ),
  Event(
    imageUrl: null,
    organizer: 'Theater Arts',
    dateTime: '2025-04-07 19:00',
    description: 'Enjoy a captivating local theater performance.',
    location: const LatLng(45.7482, 21.2100),
  ),
  Event(
    imageUrl: null,
    organizer: 'PhotoWorkshop Inc.',
    dateTime: '2025-04-08 15:00',
    description: 'Enhance your photography skills in a hands-on workshop.',
    location: const LatLng(45.7488, 21.2097),
  ),
  Event(
    imageUrl: null,
    organizer: 'Wellness Retreats',
    dateTime: '2025-04-09 08:00',
    description: 'Join us for a rejuvenating meditation and yoga retreat.',
    location: const LatLng(45.7491, 21.2103),
  ),
  Event(
    imageUrl: null,
    organizer: 'Culinary Arts',
    dateTime: '2025-04-10 14:00',
    description: 'Learn traditional Romanian recipes in our cooking class.',
    location: const LatLng(45.7484, 21.2082),
  ),
  Event(
    imageUrl: null,
    organizer: 'Fashion Forward',
    dateTime: '2025-04-11 17:00',
    description: 'Explore the latest trends at our pop-up fashion event.',
    location: const LatLng(45.7496, 21.2115),
  ),
  Event(
    imageUrl: null,
    organizer: 'Cycle Timisoara',
    dateTime: '2025-04-12 08:30',
    description: 'Join a scenic cycling tour around the city’s landmarks.',
    location: const LatLng(45.7486, 21.2091),
  ),
  Event(
    imageUrl: null,
    organizer: 'FilmFest',
    dateTime: '2025-04-13 20:30',
    description: 'Experience premieres and screenings at the film festival.',
    location: const LatLng(45.7489, 21.2104),
  ),
];
