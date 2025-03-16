import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_now_frontend/shared/widgets/top_app_bar.dart';
import 'package:help_now_frontend/core/providers/entry_list_provider.dart';
import 'package:help_now_frontend/core/services/preferences_service.dart';

import '../../chat_list/widgets/chat_input_field.dart';
import '../widgets/entry_bubble.dart';

class EntryListScreen extends ConsumerWidget {
  final int chatId;

  const EntryListScreen({
    super.key,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefsAsync = ref.watch(preferencesServiceProvider);

    return prefsAsync.when(
      data: (prefs) {
        final entryListAsync = ref.watch(entryListProvider(chatId));
        return Scaffold(
          appBar: TopAppBar(),
          body: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  Expanded(
                    child: entryListAsync.when(
                      data: (chatMessages) {
                        if (chatMessages.isEmpty) {
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
                  ChatInputField(
                    onSend: (text) {
                      ref
                          .read(entryListProvider(chatId).notifier)
                          .sendMessage(text);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator())),
      error: (error, st) =>
          Scaffold(body: Center(child: Text('Error: $error'))),
    );
  }
}
