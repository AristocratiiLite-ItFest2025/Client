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
    final mapState = ref.watch(mapViewModelProvider);
    //final bool isDark = Theme.of(context).brightness == Brightness.dark;

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
            // Apply a grayscale filter to each tile image.
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
              // Replace Colors.blue with any color you prefer.
              color: Colors.blue.withAlpha(120),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
