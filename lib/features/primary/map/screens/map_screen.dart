import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../shared/widgets/web_top_bar.dart';
import '../view_models/map_vm.dart';
import '../../../../shared/widgets/bottom_nav_bar.dart';
import '../../../../shared/widgets/top_app_bar.dart';
import '../widgets/event_marker.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapState = ref.watch(mapViewModelProvider);
    final events = mapState.events;

    // MapController to control the map.
    final MapController mapController = MapController();

    // Set initial center and zoom after the widget is built.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapController.move(mapState.center, 13.0); // Adjust zoom level (13.0) if needed
    });

    return Scaffold(
      appBar: kIsWeb ? const WebTopBar() : const TopAppBar(),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          // No center or zoom defined here
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            tileBuilder: (context, tileWidget, tile) {
              return ColorFiltered(
                colorFilter: const ColorFilter.matrix([
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0, 0, 0, 1, 0,
                ]),
                child: tileWidget,
              );
            },
          ),
          IgnorePointer(
            child: Container(
              color: Colors.blue.withAlpha(120),
            ),
          ),
          MarkerLayer(
            markers: events.map((event) {
              return Marker(
                point: LatLng(event.lat, event.lon),
                width: 40,
                height: 40,
                alignment: Alignment.center,
                child: EventMarker(event: event),
              );
            }).toList(),
          ),
        ],
      ),
      bottomNavigationBar: kIsWeb ? null : const BottomNavBar(),
    );
  }
}
