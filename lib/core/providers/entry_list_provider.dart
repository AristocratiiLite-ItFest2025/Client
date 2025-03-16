import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/primary/chat/view_models/entry_list_vm.dart';
import '../models/entry_model.dart';
import '../services/entry_service.dart';
import '../services/preferences_service.dart';

final entryListProvider = StateNotifierProvider.family<
    EntryListViewModel, AsyncValue<List<EntryModel>>, int>((ref, chatId) {

  // Listen to the preferences asynchronously.
  final prefsAsync = ref.watch(preferencesServiceProvider);

  // Extract the current user id. If loading or error, fallback to 0.
  final currentUserId = prefsAsync.when(
    data: (prefs) => prefs.profile?.id ?? 0,
    loading: () => 0,
    error: (_, __) => 0,
  );

  // Get the entry service instance. Using ref.read is acceptable here since
  // the service is unlikely to change during runtime.
  final entryService = ref.read(entryServiceProvider);

  return EntryListViewModel(
    entryService: entryService,
    chatId: chatId,
    currentUserId: currentUserId,
  );
});
