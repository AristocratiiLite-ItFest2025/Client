import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_now_frontend/core/enums/is_verified.dart';
import 'package:help_now_frontend/core/services/profile_changes_service.dart';

import '../../../../core/models/profile_model.dart';
import '../../../../core/services/preferences_service.dart';


class ProfileViewModel extends StateNotifier<AsyncValue<ProfileModel?>> {
  final PreferencesService _preferencesService;
  final ProfileChangesService _userService;

  ProfileViewModel(this._preferencesService, this._userService) : super(const AsyncValue.loading()) {
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
  Future<void> updateVerification(int userId, IsVerified newStatus) async {
    try {
      await _userService.updateUserVerification(userId: userId, isVerified: newStatus.value);
      // Locally update after API call
      final updatedProfile = _preferencesService.profile?.copyWith(verifiedType: newStatus);
      _preferencesService.setProfile(updatedProfile!);
      state = AsyncValue.data(updatedProfile);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final profileViewModelProvider = StateNotifierProvider<ProfileViewModel, AsyncValue<ProfileModel?>>((ref) {
  final prefsService = ref.watch(preferencesServiceProvider).maybeWhen(
    data: (service) => service,
    orElse: () => null,
  );

  final userService = ref.watch(profileChangesServiceProvider);

  if (prefsService == null) {
    // Return a fallback or handle loading in the UI
    return ProfileViewModel(PreferencesService(), userService);
  }

  return ProfileViewModel(prefsService, userService);
});

