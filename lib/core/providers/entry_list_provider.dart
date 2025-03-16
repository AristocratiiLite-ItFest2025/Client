import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/primary/chat/view_models/entry_list_vm.dart';
import '../models/entry_model.dart';
import '../services/entry_service.dart';
import '../services/preferences_service.dart';

final entryListProvider = StateNotifierProvider.family<
    EntryListViewModel, AsyncValue<List<EntryModel>>, int>((ref, chatId) {
  final prefsAsync = ref.watch(preferencesServiceProvider);
  int currentUserId = 0;
  prefsAsync.whenData((prefs) {
    currentUserId = prefs.userId ?? 0;
  });
  final entryService = ref.read(entryServiceProvider);
  return EntryListViewModel(
    entryService: entryService,
    chatId: chatId,
    currentUserId: currentUserId,
  );
});