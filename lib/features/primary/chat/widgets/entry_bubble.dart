import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/entry_model.dart';
import '../../../../core/utils/entry_utils.dart';
import '../../../../core/services/preferences_service.dart';

class EntryBubble extends ConsumerWidget {
  final EntryModel entry;

  const EntryBubble({super.key, required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retrieve the current user's id from preferences.
    final prefsAsync = ref.watch(preferencesServiceProvider);

    return prefsAsync.when(
      data: (prefs) {
        final myUserId = prefs.profile?.id ?? 0;
        final isMine = isEntryMine(entry, myUserId);

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
              entry.text,
              style: TextStyle(
                color: isMine ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, st) => Center(child: Text('Error: $error')),
    );
  }
}
