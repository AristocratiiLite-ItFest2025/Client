import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/models/event_model.dart';

class EventDetailDialog extends StatelessWidget {
  final EventModel event;

  const EventDetailDialog({super.key, required this.event});

  String _formatTime(DateTime dateTime) {
    return DateFormat('HH:mm, dd MMM yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Event image
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                gradient: event.image == "Null"
                    ? const LinearGradient(
                  colors: [Colors.blue, Colors.green],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                    : null,
                image: event.image != "Null"
                    ? DecorationImage(
                  image: NetworkImage(event.image),
                  fit: BoxFit.cover,
                )
                      : null,
              ),
            ),
            const SizedBox(height: 8),
            // Author and Time on separate lines
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Author: ${event.authorId}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _formatTime(event.startTime),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      _formatTime(event.endTime),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Attendees: ${event.attendees}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  "Recurring: ${event.recurringDuration}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Description
            Text(
              event.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            // Contact information
            Text(
              "Contact: ${event.phoneContact} | ${event.emailForContact}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Implement join action logic here
          },
          child: const Text("Join"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Close"),
        ),
      ],
    );
  }
}
