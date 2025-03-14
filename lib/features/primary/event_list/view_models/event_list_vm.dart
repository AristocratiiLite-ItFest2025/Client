import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    imageUrl: null, // Will trigger the gradient background
    organizer: "John Doe",
    dateTime: "Mar 25, 2025 18:00",
    description: "Join us for an exciting Flutter development event!",
  ),
  Event(
    imageUrl: null,
    organizer: "Jane Smith",
    dateTime: "Apr 1, 2025 10:00",
    description: "Learn about state management using Riverpod in Flutter.",
  ),
];
