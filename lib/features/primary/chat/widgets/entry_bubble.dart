import 'package:flutter/material.dart';
import '../../../../core/models/entry_model.dart';

class EntryBubble extends StatelessWidget {
  final EntryModel entry;

  const EntryBubble({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    // Assuming EntryModel has a bool 'isMine' to indicate if the message was sent by the current user.
    final bool isMine = entry.isMine;

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMine ? Theme.of(context).primaryColor : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMine ? const Radius.circular(16) : Radius.zero,
            bottomRight: isMine ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Text(
          entry.message,
          style: TextStyle(
            color: isMine ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
