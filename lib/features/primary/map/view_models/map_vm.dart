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
      : super(MapState(center: const LatLng(51.5, -0.09), zoom: 13.0));

  /// Example method to load and update the current location.
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
