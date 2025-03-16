import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_now_frontend/core/models/entry_model.dart';
import 'package:help_now_frontend/core/services/entry_service.dart';
import 'package:help_now_frontend/core/services/socket_service.dart';

class EntryListViewModel extends StateNotifier<AsyncValue<List<EntryModel>>> {
  final EntryService _entryService;
  final int chatId;
  final int currentUserId;
  final SocketService _socketService = SocketService();

  EntryListViewModel({
    required EntryService entryService,
    required this.chatId,
    required this.currentUserId,
  }) : _entryService = entryService,
        super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    fetchEntries();
    _socketService.joinChat(chatId);
    _socketService.listenForMessages(_handleIncomingMessage);
  }

  Future<void> fetchEntries() async {
    try {
      final entries = await _entryService.fetchEntries(chatId);
      state = AsyncValue.data(entries);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> sendMessage(String text) async {
    try {
      final newEntry = EntryModel(
        text: text,
        userId: currentUserId, // use the current user id here.
        chatId: chatId,
        timestamp: DateTime.now(),
        id: 0,
      );
      _socketService.sendMessage(newEntry.toJson());
      state.whenData((entries) {
        state = AsyncValue.data([newEntry, ...entries]);
      });
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Determines if the given entry belongs to the current user.
  bool isEntryMine(EntryModel entry) {
    return entry.userId == currentUserId;
  }

  void _handleIncomingMessage(dynamic data) {
    final incomingEntry = EntryModel.fromJson(data);
    state.whenData((entries) {
      state = AsyncValue.data([incomingEntry, ...entries]);
    });
  }

  @override
  void dispose() {
    _socketService.leaveChat(chatId);
    super.dispose();
  }
}
