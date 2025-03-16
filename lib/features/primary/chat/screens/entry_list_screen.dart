import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_now_frontend/shared/widgets/top_app_bar.dart';
import 'package:help_now_frontend/core/providers/entry_list_provider.dart';
import 'package:help_now_frontend/core/services/preferences_service.dart';

import '../widgets/entry_bubble.dart';

class EntryListScreen extends ConsumerWidget {
  final int chatId;

  const EntryListScreen({super.key, required this.chatId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retrieve the preferences to get the current user id.
    final prefsAsync = ref.watch(preferencesServiceProvider);

    return prefsAsync.when(
      data: (prefs) {
        // current user id is available here if needed.
        final chatMessagesAsync = ref.watch(entryListProvider(chatId));

        return Scaffold(
          appBar: TopAppBar(),
          body: Column(
            children: [
              Expanded(
                child: chatMessagesAsync.when(
                  data: (chatMessages) {
                    if (chatMessages.isEmpty) {
                      // Display a placeholder if there are no messages.
                      return const Center(
                        child: Text(
                          'No messages yet',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      reverse: true,
                      itemCount: chatMessages.length,
                      itemBuilder: (context, index) {
                        final message = chatMessages[index];
                        return EntryBubble(entry: message);
                      },
                    );
                  },
                  loading: () =>
                  const Center(child: CircularProgressIndicator()),
                  error: (error, stack) =>
                      Center(child: Text('Error: $error')),
                ),
              ),
              _ChatInputField(
                onSend: () {
                  // Replace with your actual send message logic.
                  // For example: ref.read(entryListProvider(chatId).notifier).sendMessage(messageText);
                },
              ),
            ],
          ),
        );
      },
      loading: () =>
      const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, st) =>
          Scaffold(body: Center(child: Text('Error: $error'))),
    );
  }
}

class _ChatInputField extends StatelessWidget {
  final VoidCallback onSend;

  const _ChatInputField({Key? key, required this.onSend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onSubmitted: (_) => onSend(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blueAccent),
            onPressed: onSend,
          ),
        ],
      ),
    );
  }
}
