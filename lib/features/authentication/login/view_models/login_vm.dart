import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/enums/app_screen.dart';
import '../../../../core/models/profile_model.dart';
import '../../../../core/navigation/navigation_manager.dart';
import '../../../../core/services/preferences_service.dart';
import '../../../../core/services/repositories/auth_repository.dart';

class LoginState {
  final bool isLoading;
  final String? errorMessage;

  const LoginState({this.isLoading = false, this.errorMessage});

  LoginState copyWith({bool? isLoading, String? errorMessage}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class LoginViewModel extends StateNotifier<LoginState> {
  final AuthRepository _authRepository;
  final Ref _ref;

  LoginViewModel(this._authRepository, this._ref) : super(const LoginState());

  Future<void> login(String username, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      // Perform login to get the profile.
      final ProfileModel profile = await _authRepository.login(username, password);

      // Retrieve the PreferencesService instance from Riverpod.
      final prefsService = await _ref.read(preferencesServiceProvider.future);

      // Store the profile in preferences.
      await prefsService.setProfile(profile);

      state = state.copyWith(isLoading: false);

      // Navigate to the MapScreen (or any other desired screen) on success.
      _ref.read(navigationManagerProvider.notifier).navigateTo(AppScreen.map);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final loginViewModelProvider =
StateNotifierProvider<LoginViewModel, LoginState>((ref) {
  return LoginViewModel(AuthRepository(), ref);
});
