import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/models/event_model.dart';
import '../../../../core/services/event_service.dart';
import '../../../../core/services/map_service.dart';

class MapState {
  final LatLng center;
  final double zoom;
  final List<EventModel> events;

  MapState({
    required this.center,
    required this.zoom,
    required this.events,
  });

  MapState copyWith({
    LatLng? center,
    double? zoom,
    List<EventModel>? events,
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
  final EventService _eventService;

  MapViewModel(this._mapService, this._eventService)
      : super(MapState(
    center: const LatLng(45.7489, 21.2087),
    zoom: 13,
    events: [],
  )) {
    loadEvents();
  }

  Future<void> loadCurrentLocation() async {
    final currentLocation = await _mapService.getCurrentLocation();
    state = state.copyWith(center: currentLocation);
  }

  Future<void> loadEvents() async {
    try {
      final events = await _eventService.fetchEvents();
      state = state.copyWith(events: events);
    } catch (e) {
      // Handle error accordingly.
    }
  }
}

final mapViewModelProvider =
StateNotifierProvider<MapViewModel, MapState>((ref) {
  final mapService = MapService();
  final eventService = EventService();
  return MapViewModel(mapService, eventService);
});
