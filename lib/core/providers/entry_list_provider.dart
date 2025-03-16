import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/primary/chat/view_models/entry_list_vm.dart';
import '../models/entry_model.dart';
import '../services/entry_service.dart';
import '../services/preferences_service.dart';

final entryListProvider = StateNotifierProvider.family<
    EntryListViewModel, AsyncValue<List<EntryModel>>, int>((ref, chatId) {

  final currentUserId = ref.watch(preferencesServiceProvider).maybeWhen(
    data: (prefs) => prefs.profile?.id ?? 0,
    orElse: () => 0,
  );

  final entryService = ref.read(entryServiceProvider);
  return EntryListViewModel(
    entryService: entryService,
    chatId: chatId,
    currentUserId: currentUserId,
  );
});
