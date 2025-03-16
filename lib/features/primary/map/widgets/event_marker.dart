import 'package:flutter/material.dart';
import 'package:help_now_frontend/shared/widgets/event_card/event_entry_card.dart';
import '../../../../core/models/event_model.dart';

class EventMarker extends StatelessWidget {
  final EventModel event;

  const EventMarker({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final Offset markerPosition = renderBox.localToGlobal(Offset.zero);

        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: MaterialLocalizations.of(context)
              .modalBarrierDismissLabel,
          barrierColor: Colors.black54,
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) {
            return Stack(
              children: [
                Positioned(
                  left: markerPosition.dx - 100,
                  top: markerPosition.dy - 150,
                  child: Material(
                    color: Colors.transparent,
                    child: EventCard(event: event),
                  ),
                ),
              ],
            );
          },
          transitionBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorScheme.primary,
        ),
        child: ClipOval(
          child: Image.network(
            event.iconImage,
            fit: BoxFit.cover,
            // Fallback in case the image fails to load
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.event,
              color: colorScheme.onPrimary,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
