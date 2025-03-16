import '../models/entry_model.dart';

bool isEntryMine(EntryModel entry, int currentUserId) {
  return entry.userId == currentUserId;
}