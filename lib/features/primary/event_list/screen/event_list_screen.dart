import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/bottom_nav_bar.dart';
import '../../../../shared/widgets/top_app_bar.dart';
import '../view_models/event_list_vm.dart';
import '../widgets/event_card.dart';

class EventListScreen extends ConsumerWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventViewModelProvider);

    return Scaffold(
      appBar: const TopAppBar(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: EventCard(
              imageUrl: event.imageUrl,
              organizer: event.organizer,
              dateTime: event.dateTime,
              description: event.description,
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
