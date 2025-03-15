import 'package:flutter/material.dart';

import '../../../../core/models/event_model.dart';
import '../../../../shared/widgets/event_card.dart';

class EventMarker extends StatelessWidget {
  final Event event;

  const EventMarker({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final Offset markerPosition = renderBox.localToGlobal(Offset.zero);

        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
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
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            Icons.event,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 30,
          ),
        ),
      ),
    );
  }
}