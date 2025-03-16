import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/event_model.dart';
import '../../../../core/services/event_service.dart';

/// The view model for our event list. It now uses [EventService] to load
/// events from the backend instead of using mock data.
class EventListVM extends StateNotifier<List<EventModel>> {
  final EventService _eventService;

  EventListVM(this._eventService) : super([]) {
    loadEvents();
  }

  Future<void> loadEvents() async {
    try {
      final events = await _eventService.fetchEvents();
      state = events;
    } catch (e) {
      // Handle error appropriately (e.g., logging or state update).
      debugPrint("Error loading events: $e");
    }
  }
}

/// Provider exposing the EventListVM.
final eventViewModelProvider =
StateNotifierProvider<EventListVM, List<EventModel>>((ref) {
  final eventService = EventService();
  return EventListVM(eventService);
});
