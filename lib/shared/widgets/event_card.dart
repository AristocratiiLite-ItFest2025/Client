import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/models/event_model.dart';

class EventCard extends StatelessWidget {
  final EventModel event;

  const EventCard({super.key, required this.event});

  String _formatTime(DateTime dateTime) {
    return DateFormat('HH:mm, dd MMM yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image section
          Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(event.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Row with author id and start/end time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Author: ${event.authorId}",
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(
                      "${_formatTime(event.startTime)} - ${_formatTime(event.endTime)}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Row with number of attendees and recurring duration
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Attendees: ${event.attendees}",
                        style: Theme.of(context).textTheme.bodySmall),
                    Text("Recurring: ${event.recurringDuration}",
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
