import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/models/event_model.dart';
import '../../../../core/models/profile_model.dart';
import '../../../../core/services/event_service.dart';
import '../../../../core/services/map_service.dart';
import '../../../../core/services/preferences_service.dart';
import '../../../../core/enums/is_verified.dart';

class MapState {
  final LatLng center;
  final double zoom;
  final List<EventModel> events;
  final ProfileModel? profile;
  final bool isSponsor;

  MapState({
    required this.center,
    required this.zoom,
    required this.events,
    required this.profile,
    required this.isSponsor,
  });

  MapState copyWith({
    LatLng? center,
    double? zoom,
    List<EventModel>? events,
    ProfileModel? profile,
    bool? isSponsor,
  }) {
    return MapState(
      center: center ?? this.center,
      zoom: zoom ?? this.zoom,
      events: events ?? this.events,
      profile: profile ?? this.profile,
      isSponsor: isSponsor ?? this.isSponsor,
    );
  }
}

class MapViewModel extends StateNotifier<MapState> {
  final MapService _mapService;
  final EventService _eventService;
  final PreferencesService _preferencesService;

  MapViewModel(
      this._mapService,
      this._eventService,
      this._preferencesService,
      ) : super(MapState(
    center: const LatLng(45.7489, 21.2087),
    zoom: 13,
    events: [],
    profile: null,
    isSponsor: false,
  )) {
    _init();
  }

  Future<void> _init() async {
    await loadProfile();
    await loadEvents();
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
      // Ideally log error here or use a logger.
    }
  }

  Future<void> loadProfile() async {
    final profile = _preferencesService.profile;
    final sponsor = profile?.verifiedType == IsVerified.SPONSOR;
    state = state.copyWith(profile: profile, isSponsor: sponsor);
  }

  /// Optional: Refresh all
  Future<void> refreshAll() async {
    await loadProfile();
    await loadEvents();
  }

  Future<void> createEvent(EventModel event) async {
    try {
      final createdEvent = await _eventService.createEvent(event);
      debugPrint("✅ Event created successfully: ${createdEvent.toJson()}");

      // Optional: Refresh event list after creation
      await loadEvents();
      refreshAll();
    } catch (e) {
      debugPrint("❌ Error creating event: $e");
    }
  }
}

final mapViewModelProvider =
StateNotifierProvider<MapViewModel, MapState>((ref) {
  final mapService = MapService();
  final eventService = EventService();
  final preferencesService = PreferencesService();
  return MapViewModel(mapService, eventService, preferencesService);
});