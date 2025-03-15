import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapService {
  /// Set this to false if you want to use the actual geolocation functionality.
  final bool useMockLocation = true;

  /// Retrieves the current location.
  /// When [useMockLocation] is true, returns the coordinates for Timișoara, Romania.
  Future<LatLng> getCurrentLocation() async {
    if (useMockLocation) {
      // Coordinates for Timișoara, Romania.
      return LatLng(45.7489, 21.2087);
    } else {
      // Check if location services are enabled.
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      // Check for location permissions.
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Location permissions are permanently denied. Please enable them in settings.');
      }

      // Define desired accuracy based on the platform.
      LocationAccuracy desiredAccuracy;
      if (kIsWeb) {
        desiredAccuracy = LocationAccuracy.high;
      } else if (Platform.isAndroid) {
        desiredAccuracy = LocationAccuracy.high;
      } else if (Platform.isIOS) {
        desiredAccuracy = LocationAccuracy.high;
      } else {
        desiredAccuracy = LocationAccuracy.high;
      }

      // Retrieve the current position using the desired accuracy.
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: desiredAccuracy,
      );
      return LatLng(position.latitude, position.longitude);
    }
  }
}
