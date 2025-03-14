import 'package:latlong2/latlong.dart';

class MapService {
  /// Simulate a network or device call to get the current location.
  /// In a real app, integrate with a package like `geolocator` or `location`.
  Future<LatLng> getCurrentLocation() async {
    await Future.delayed(const Duration(seconds: 1));
    return const LatLng(45.7489, 21.2087);
  }
}
