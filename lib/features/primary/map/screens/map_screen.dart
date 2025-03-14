import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';

import '../view_models/map_vm.dart';
import '../../../../shared/widgets/bottom_nav_bar.dart';
import '../../../../shared/widgets/top_app_bar.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to map state from the view model.
    final mapState = ref.watch(mapViewModelProvider);

    return Scaffold(
      appBar: const TopAppBar(),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: mapState.center,
          initialZoom: mapState.zoom,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          // Add more layers such as MarkerLayer here.
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
