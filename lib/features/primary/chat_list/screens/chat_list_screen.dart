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
    final chatList = ref.watch(chatListProvider);

    return Scaffold(
      appBar: kIsWeb
          ? const WebTopBar() // Web-specific top bar
          : const TopAppBar(), // Mobile-specific top bar
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600, // Adjust width as needed
          ),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemCount: chatList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ChatCard(chat: chatList[index]), // Chat card with spacing
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: kIsWeb
          ? null // No bottom nav bar for web
          : const BottomNavBar(), // Bottom nav bar for mobile
    );
  }
}
