import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/chat_model.dart';
import '../../../../core/services/chat_service.dart';
import '../../../../core/services/preferences_service.dart';

class ChatListViewModel extends StateNotifier<AsyncValue<List<ChatModel>>> {
  final ChatService _chatService;
  final int _userId;

  ChatListViewModel({required ChatService chatService, required int userId})
      : _chatService = chatService,
        _userId = userId,
        super(const AsyncValue.loading()) {
    fetchChats();
  }

  Future<void> fetchChats() async {
    try {
      final chats = await _chatService.fetchChats(_userId);
      state = AsyncValue.data(chats);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final chatListProvider = StateNotifierProvider<ChatListViewModel, AsyncValue<List<ChatModel>>>((ref) {
  final chatService = ref.read(chatServiceProvider);
  final userId = PreferencesService().userId; // Assumes you already have user id stored.
  return ChatListViewModel(chatService: chatService, userId: userId!);
});
