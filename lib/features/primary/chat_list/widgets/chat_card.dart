import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums/app_screen.dart';
import '../../../../core/models/chat_model.dart';
import '../../../../core/navigation/navigation_manager.dart';

class ChatCard extends ConsumerWidget {
  final ChatModel chat;
  final int userid;
  ChatCard({super.key, required this.chat, required this.userid});

  final chatCardProvider = Provider.family<ChatModel, ChatModel>(
        (ref, chat) {
      return chat;
    },
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatData = ref.watch(chatCardProvider(chat));

    return InkWell(
      onTap: () {
        ref.read(navigationManagerProvider.notifier)
            .navigateTo(AppScreen.entryList, arguments: chat.id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Left side: display an image if available; otherwise, show an icon.
              /*chatData.imageUrl != null && chatData.imageUrl!.isNotEmpty
                  ? CircleAvatar(
                backgroundImage: NetworkImage(chatData.imageUrl!),
                radius: 24,
              )
                  : const CircleAvatar(
                radius: 24,
                child: Icon(Icons.chat_bubble),
              ),*///Todo Change to before, after raul fixes backend
              CircleAvatar(
                radius: 24,
                child: Icon(Icons.chat_bubble)),
              const SizedBox(width: 12),
              // Right side: a column with the title and a row with the last message and its timestamp.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatData.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "hi",
                            style: Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          chatData.lastMessageTimestamp != null
                              ? _formatTimestamp(chatData.lastMessageTimestamp!)
                              : '',
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
      ),
    );
  }

  // Helper method to format the timestamp (e.g., HH:mm).
  String _formatTimestamp(DateTime timestamp) {
    final hours = timestamp.hour.toString().padLeft(2, '0');
    final minutes = timestamp.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
}
