import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/chat_model.dart';
import '../view_models/chat_list_vm.dart';

class ChatCard extends ConsumerWidget {
  final Chat chat;
  const ChatCard({super.key, required this.chat});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatData = ref.watch(chatCardProvider(chat));

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Left side: display an image if available; otherwise, show an icon.
            chatData.imageUrl != null && chatData.imageUrl!.isNotEmpty
                ? CircleAvatar(
              backgroundImage: NetworkImage(chatData.imageUrl!),
              radius: 24,
            )
                : const CircleAvatar(
              radius: 24,
              child: Icon(Icons.chat_bubble),
            ),
            const SizedBox(width: 12),
            // Right side: a column containing the title and a row with the last message and its timestamp.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title of the chat.
                  Text(
                    chatData.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  // Row with the last message and timestamp.
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chatData.lastMessage,
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        _formatTimestamp(chatData.lastMessageTimestamp),
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

  // Helper method to format the timestamp (e.g., as HH:mm).
  String _formatTimestamp(DateTime timestamp) {
    final hours = timestamp.hour.toString().padLeft(2, '0');
    final minutes = timestamp.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
}
