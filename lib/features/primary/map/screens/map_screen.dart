import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/models/event_model.dart';
import '../../../../shared/widgets/web_top_bar.dart';
import '../view_models/map_vm.dart';
import '../../../../shared/widgets/bottom_nav_bar.dart';
import '../../../../shared/widgets/top_app_bar.dart';
import '../widgets/event_marker.dart';
import '../../../../core/enums/is_verified.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  bool _isSelecting = false;

  void _onMapTap(TapPosition tapPosition, LatLng latLng) {
    if (_isSelecting) {
      final profile = ref.read(mapViewModelProvider).profile;

      final TextEditingController nameController = TextEditingController();
      final TextEditingController descriptionController = TextEditingController();
      final TextEditingController phoneController = TextEditingController();
      final TextEditingController emailController = TextEditingController(text: profile?.email ?? '');

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Create Event'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('User: ${profile?.username ?? 'Unknown'}'),
                  Text('Email: ${profile?.email ?? 'Unknown'}'),
                  Text('Lat: ${latLng.latitude.toStringAsFixed(5)}'),
                  Text('Lon: ${latLng.longitude.toStringAsFixed(5)}'),
                  const SizedBox(height: 10),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Event Name'),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: 'Phone Contact'),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email for Contact'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  final event = EventModel(
                    id: -1, // Placeholder
                    authorId: profile?.id ?? -1,
                    name: nameController.text,
                    description: descriptionController.text,
                    image: null,
                    iconImage: null,
                    startTime: DateTime.now(),
                    endTime: DateTime.now().add(const Duration(hours: 2)),
                    attendees: [],
                    attendeesCount: 0,
                    recurringDuration: null,
                    emailForContact: emailController.text,
                    phoneContact: phoneController.text,
                    lat: latLng.latitude,
                    lon: latLng.longitude,
                  );

                  ref.read(mapViewModelProvider.notifier).createEvent(event);

                  Navigator.of(context).pop();
                },
                child: const Text('Accept'),
              ),
            ],
          );
        },
      );

      setState(() {
        _isSelecting = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final mapState = ref.watch(mapViewModelProvider);
    final events = mapState.events;
    final isNGO = mapState.profile?.verifiedType == IsVerified.NGO;

    return Scaffold(
      appBar: kIsWeb ? const WebTopBar() : const TopAppBar(),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: mapState.center,
          initialZoom: mapState.zoom,
          onTap: _onMapTap,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            tileBuilder: (context, tileWidget, tile) {
              return ColorFiltered(
                colorFilter: const ColorFilter.matrix([
                  0.66, 0.7152, 0.0722, 0, 0,
                  0.66, 0.7152, 0.0722, 0, 0,
                  0.66, 0.7152, 0.0722, 0, 0,
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
      floatingActionButton: isNGO
          ? FloatingActionButton(
        onPressed: () {
          setState(() {
            _isSelecting = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Select place for event'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: const Icon(Icons.add_location_alt),
      )
          : null,
      bottomNavigationBar: kIsWeb ? null : const BottomNavBar(),
    );
  }
}
