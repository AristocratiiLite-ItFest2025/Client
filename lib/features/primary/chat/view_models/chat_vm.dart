import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/entry_model.dart';
import '../../../../core/services/preferences_service.dart';

class ChatViewModel extends StateNotifier<List<EntryModel>> {
  ChatViewModel()
      : super([
    // Chat id 1
    EntryModel(
      chatId: 1,
      message: 'Hi there! How are you?',
      isMine: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 60)),
    ),
    EntryModel(
      chatId: 1,
      message: 'I\'m good, thanks! How about you?',
      isMine: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 55)),
    ),
    EntryModel(
      chatId: 1,
      message: 'Doing well, thanks for asking.',
      isMine: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 50)),
    ),
    EntryModel(
      chatId: 1,
      message: 'What are your plans for today?',
      isMine: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
    ),
    EntryModel(
      chatId: 1,
      message: 'I might catch up on some work and then relax.',
      isMine: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 40)),
    ),
    EntryModel(
      chatId: 1,
      message: 'Sounds like a plan. Enjoy your day!',
      isMine: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 38)),
    ),
    // Chat id 2
    EntryModel(
      chatId: 2,
      message: 'Hey, are you joining the meeting?',
      isMine: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    EntryModel(
      chatId: 2,
      message: 'Yes, I will be there in 5 minutes.',
      isMine: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 28)),
    ),
    EntryModel(
      chatId: 2,
      message: 'Great, see you there!',
      isMine: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 26)),
    ),
    EntryModel(
      chatId: 2,
      message: 'Let me know if you need help with anything during the meeting.',
      isMine: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
    ),
    EntryModel(
      chatId: 2,
      message: 'Will do, thanks!',
      isMine: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 23)),
    ),
    // Chat id 3
    EntryModel(
      chatId: 3,
      message: 'Let\'s catch up later!',
      isMine: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 20)),
    ),
    EntryModel(
      chatId: 3,
      message: 'Sure, how about tomorrow evening?',
      isMine: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 18)),
    ),
    EntryModel(
      chatId: 3,
      message: 'Tomorrow evening works perfectly for me.',
      isMine: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 16)),
    ),
    EntryModel(
      chatId: 3,
      message: 'Looking forward to it!',
      isMine: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 14)),
    ),
    EntryModel(
      chatId: 3,
      message: 'Great, see you then.',
      isMine: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 12)),
    ),
  ]) {
    final userId = PreferencesService().userId;
    debugPrint("ChatViewModel created, userId: $userId");
  }

  List<EntryModel> getChatMessages(int chatId) {
    return state.where((msg) => msg.chatId == chatId).toList();
  }
// Additional methods to manipulate chat entries can be added here.
}

// Riverpod provider for the chat messages.
final chatProvider = StateNotifierProvider<ChatViewModel, List<EntryModel>>(
      (ref) => ChatViewModel(),
);
