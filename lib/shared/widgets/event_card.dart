import 'package:flutter/material.dart';

import '../../core/models/event_model.dart';


class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    // A smaller card version used in the dialog.
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 220, // adjust width as needed
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Smaller image container
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                image: event.imageUrl != null
                    ? DecorationImage(
                  image: NetworkImage(event.imageUrl!),
                  fit: BoxFit.cover,
                )
                    : null,
                gradient: event.imageUrl == null
                    ? const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                    : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        event.organizer,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        event.dateTime,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
