import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/bottom_nav_bar.dart';
import '../../../../shared/widgets/top_app_bar.dart';
import '../../../../shared/widgets/web_top_bar.dart';
import '../view_models/event_list_vm.dart';
import 'package:help_now_frontend/shared/widgets/event_card/event_entry_card.dart';

class EventListScreen extends ConsumerWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventViewModelProvider);

    return Scaffold(
      appBar: kIsWeb ? const WebTopBar() : const TopAppBar(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: EventCard(event: event),
          );
        },
      ),
      bottomNavigationBar: kIsWeb ? null : const BottomNavBar(),
    );
  }
}
