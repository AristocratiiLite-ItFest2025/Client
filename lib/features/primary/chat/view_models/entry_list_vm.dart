import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_now_frontend/core/models/entry_model.dart';
import 'package:help_now_frontend/core/services/entry_service.dart';
import 'package:help_now_frontend/core/services/socket_service.dart';

class EntryListViewModel extends StateNotifier<AsyncValue<List<EntryModel>>> {
  final EntryService _entryService;
  final int chatId;
  final int _currentUserId;
  final SocketService _socketService = SocketService();

  EntryListViewModel({
    required EntryService entryService,
    required this.chatId,
    required int currentUserId,
  })  : _currentUserId = currentUserId,
        _entryService = entryService,
        super(const AsyncValue.data([])) {
    _init();
  }

  int get currentUserId => _currentUserId;

  void _init() {
    _socketService.joinChat(chatId,currentUserId);
    _socketService.listenForMessages(_handleIncomingMessage);
    fetchEntries();
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
      _socketService.sendMessage(text,chatId,currentUserId);

      // Do not update the state immediately; wait for the backend to broadcast
      // the new entry via the socket event listener.
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void _handleIncomingMessage(dynamic data) {
    try {
      final decodedData = data is String ? json.decode(data) : data;
      debugPrint(decodedData.toString());
      final incomingEntry = EntryModel.fromJson(decodedData);
      state.whenData((entries) {
        state = AsyncValue.data([incomingEntry, ...entries]);
      });
    } catch (e) {
      debugPrint("Error parsing incoming socket message: $e");
    }
  }


  @override
  void dispose() {
    _socketService.leaveChat(chatId,currentUserId);
    super.dispose();
  }
}
