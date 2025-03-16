import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_now_frontend/shared/widgets/top_app_bar.dart';

import '../view_models/chat_vm.dart';

class ChatScreen extends ConsumerWidget {
  final int chatId;

  const ChatScreen({super.key, required this.chatId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retrieve reversed chat messages from the view model.
    final chatMessages = ref.watch(chatProvider.notifier).getChatMessages(chatId);

    return Scaffold(
      appBar: const TopAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              reverse: false,
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                final message = chatMessages[index];
                return Align(
                  alignment:
                  message.isMine ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: message.isMine
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      message.message,
                      style: TextStyle(
                        color: message.isMine
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const _ChatInputField(),
        ],
      ),
    );
  }
}

// Simple input field for sending messages.
class _ChatInputField extends StatelessWidget {
  const _ChatInputField(); // Added const constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(153),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              // Implement send message logic here.
            },
          ),
        ],
      ),
    );
  }
}
