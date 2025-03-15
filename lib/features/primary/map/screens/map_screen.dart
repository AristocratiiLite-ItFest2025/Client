import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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

    return Scaffold(
      appBar: const TopAppBar(),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: mapState.center,
          initialZoom: mapState.zoom,
          // If your map supports rotation, ensure mapState.rotation is available:
          // rotation: mapState.rotation,
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
                point: LatLng(event.lat,event.lon),
                width: 40,
                height: 40,
                alignment: Alignment.center,
                child: EventMarker(
                  event: event, // pass rotation if applicable
                ),
              );
            }).toList(),
          )
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
