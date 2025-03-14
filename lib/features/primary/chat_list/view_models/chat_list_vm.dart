import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/chat_model.dart';

/// ViewModel for a single chat_list card.
/// This class extends StateNotifier to manage the state of a Chat instance.
class ChatCardViewModel extends StateNotifier<Chat> {
  ChatCardViewModel(super.chat);

// In a real-world scenario, you can add methods here to update the chat_list state.
}

/// Provider for a single ChatCardViewModel using a family to pass a specific Chat.
final chatCardProvider =
StateNotifierProvider.family<ChatCardViewModel, Chat, Chat>(
      (ref, chat) => ChatCardViewModel(chat),
);

/// ViewModel for a list of chats containing mockup data.
class ChatListViewModel extends StateNotifier<List<Chat>> {
  ChatListViewModel() : super(_mockChats);

  // Mockup data for demonstration.
  static List<Chat> get _mockChats => [
    Chat(
      title: 'General Chat',
      lastMessage: 'Hey there! How are you?',
      lastMessageTimestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      imageUrl: null,
    ),
    Chat(
      title: 'Flutter Devs',
      lastMessage: 'Check out the new Flutter update!',
      lastMessageTimestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      imageUrl: null,
    ),
    Chat(
      title: 'Riverpod Chat',
      lastMessage: 'Riverpod is awesome for state management.',
      lastMessageTimestamp: DateTime.now().subtract(const Duration(minutes: 25)),
      imageUrl: null,
    ),
  ];
}

/// Provider for the chat_list list.
final chatListProvider =
StateNotifierProvider<ChatListViewModel, List<Chat>>(
      (ref) => ChatListViewModel(),
);
