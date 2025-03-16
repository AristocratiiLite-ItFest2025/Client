import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/chat_model.dart';

/// ViewModel for a single chat_list card.
/// This class extends StateNotifier to manage the state of a Chat instance.
class ChatCardViewModel extends StateNotifier<ChatModel> {
  ChatCardViewModel(super.chat);

// In a real-world scenario, you can add methods here to update the chat_list state.
}

/// Provider for a single ChatCardViewModel using a family to pass a specific Chat.
final chatCardProvider =
StateNotifierProvider.family<ChatCardViewModel, ChatModel, ChatModel>(
      (ref, chat) => ChatCardViewModel(chat),
);

/// ViewModel for a list of chats containing mockup data.
class ChatListViewModel extends StateNotifier<List<ChatModel>> {
  ChatListViewModel() : super(_mockChats);

  // Mockup data for demonstration.
  static List<ChatModel> get _mockChats => [
    ChatModel(
      id: 1,
      title: 'General Chat',
      lastMessage: 'Sounds like a plan. Enjoy your day!',
      lastMessageTimestamp: DateTime.now().subtract(const Duration(minutes: 38)),
      imageUrl: null,
    ),
    ChatModel(
      id: 2,
      title: 'Meeting Chat',
      lastMessage: 'Will do, thanks!',
      lastMessageTimestamp: DateTime.now().subtract(const Duration(minutes: 23)),
      imageUrl: null,
    ),
    ChatModel(
      id: 3,
      title: 'Riverpod Chat',
      lastMessage: 'Great, see you then.',
      lastMessageTimestamp: DateTime.now().subtract(const Duration(minutes: 12)),
      imageUrl: null,
    ),
  ];
}



/// Provider for the chat_list list.
final chatListProvider =
StateNotifierProvider<ChatListViewModel, List<ChatModel>>(
      (ref) => ChatListViewModel(),
);
