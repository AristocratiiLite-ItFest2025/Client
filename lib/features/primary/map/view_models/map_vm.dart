import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/services/map_service.dart';

/// Model class to hold map state.
class MapState {
  final LatLng center;
  final double zoom;

  MapState({
    required this.center,
    required this.zoom,
  });

  MapState copyWith({
    LatLng? center,
    double? zoom,
  }) {
    return MapState(
      center: center ?? this.center,
      zoom: zoom ?? this.zoom,
    );
  }
}

/// View model using Riverpod StateNotifier.
class MapViewModel extends StateNotifier<MapState> {
  final MapService _mapService;

  MapViewModel(this._mapService)
      : super(MapState(center: const LatLng(45.7489, 21.2087), zoom: 13));

  /// Loads the current location and updates the map center.
  Future<void> loadCurrentLocation() async {
    final currentLocation = await _mapService.getCurrentLocation();
    state = state.copyWith(center: currentLocation);
  }
}

/// Riverpod provider for the MapViewModel.
final mapViewModelProvider =
StateNotifierProvider<MapViewModel, MapState>((ref) {
  final mapService = MapService();
  return MapViewModel(mapService);
});
