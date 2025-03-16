import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/bottom_nav_bar.dart';
import '../../../../shared/widgets/top_app_bar.dart';
import '../../../../shared/widgets/web_top_bar.dart';
import '../view_models/chat_list_vm.dart';
import '../widgets/chat_card.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatListAsync = ref.watch(chatListProvider);

    return Scaffold(
      appBar: kIsWeb ? const WebTopBar() : const TopAppBar(),
      body: chatListAsync.when(
        data: (chats) => ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) => ChatCard(chat: chats[index]),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
      bottomNavigationBar: kIsWeb ? null : const BottomNavBar(),
    );
  }
}
