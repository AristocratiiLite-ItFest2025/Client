import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums/app_screen.dart';
import '../../../../core/navigation/navigation_manager.dart';
import '../../../../core/services/repositories/auth_repository.dart';

class RegisterState {
  final bool isLoading;
  final String? errorMessage;

  const RegisterState({this.isLoading = false, this.errorMessage});

  RegisterState copyWith({bool? isLoading, String? errorMessage}) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class RegisterViewModel extends StateNotifier<RegisterState> {
  final AuthRepository _authRepository;
  final Ref _ref; // Use Ref instead of Reader

  RegisterViewModel(this._authRepository, this._ref)
      : super(const RegisterState());

  Future<void> register(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _authRepository.register(email, password);
      state = state.copyWith(isLoading: false);
      // Navigate to the MapScreen (or any other screen) on success.
      _ref.read(navigationManagerProvider.notifier).navigateTo(AppScreen.map);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final registerViewModelProvider =
StateNotifierProvider<RegisterViewModel, RegisterState>((ref) {
  return RegisterViewModel(AuthRepository(), ref);
});
