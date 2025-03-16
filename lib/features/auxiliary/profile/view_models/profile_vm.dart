import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/profile_model.dart';
import '../../../../core/services/preferences_service.dart';

class ProfileViewModel extends StateNotifier<AsyncValue<ProfileModel?>> {
  final PreferencesService _preferencesService;

  ProfileViewModel(this._preferencesService) : super(const AsyncValue.loading()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      final profile = _preferencesService.profile;
      state = AsyncValue.data(profile);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// Provider for the ProfileViewModel.
final profileViewModelProvider = StateNotifierProvider<ProfileViewModel, AsyncValue<ProfileModel?>>((ref) {
  // Wait for PreferencesService to be ready.
  final prefsService = ref.watch(preferencesServiceProvider).maybeWhen(
    data: (service) => service,
    orElse: () => null,
  );
  // If not yet loaded, return a temporary instance (the widget can show a loader until the provider is updated).
  if (prefsService == null) {
    return ProfileViewModel(PreferencesService());
  }
  return ProfileViewModel(prefsService);
});
