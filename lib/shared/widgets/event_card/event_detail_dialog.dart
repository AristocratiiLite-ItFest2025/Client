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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      backgroundColor: colorScheme.surfaceContainerHighest, // Material3 adaptive background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Event image with rounded corners
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(event.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Author and Time on separate lines
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Author: ${event.authorId}",
                  style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _formatTime(event.startTime),
                      style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.primary),
                    ),
                    Text(
                      _formatTime(event.endTime),
                      style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.secondary),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Attendees and Recurring Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Attendees: ${event.attendees}",
                  style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
                Text(
                  "Recurring: ${event.recurringDuration}",
                  style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.tertiary),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Event Description
            Text(
              event.description,
              style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
            ),
            const SizedBox(height: 12),

            // Contact Information
            Text(
              "Contact: ${event.phoneContact} | ${event.emailForContact}",
              style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.primary),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Implement join action logic here
          },
          style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
          child: const Text("Join"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(foregroundColor: colorScheme.error),
          child: const Text("Close"),
        ),
      ],
    );
  }
}
