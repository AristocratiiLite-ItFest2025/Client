import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/models/event_model.dart';
import 'event_detail_dialog.dart';

class EventCard extends StatelessWidget {
  final EventModel event;

  const EventCard({super.key, required this.event});

  String _formatTime(DateTime dateTime) {
    return DateFormat('HH:mm, dd MMM yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () {
        // On tap, open the larger event detail dialog.
        showDialog(
          context: context,
          builder: (context) => EventDetailDialog(event: event),
        );
      },
      child: Card(
        color: colorScheme.surfaceContainerHighest, // Adaptive background color
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: 220, // Adjust width as needed
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image section with gradient fallback
              Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  gradient: event.image == "Null"
                      ? LinearGradient(
                    colors: [colorScheme.primary, colorScheme.secondary],
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row with author ID and event time
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
                    const SizedBox(height: 4),
                    // Row with attendees and recurring duration
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
