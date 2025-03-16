import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/repositories/auth_repository.dart';

class RegisterState {
  final bool isLoading;
  final String? errorMessage;
  final bool registrationSuccess;

  const RegisterState({
    this.isLoading = false,
    this.errorMessage,
    this.registrationSuccess = false,
  });

  RegisterState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? registrationSuccess,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      registrationSuccess: registrationSuccess ?? this.registrationSuccess,
    );
  }
}

class RegisterViewModel extends StateNotifier<RegisterState> {
  final AuthRepository _authRepository;

  RegisterViewModel(this._authRepository)
      : super(const RegisterState());

  Future<void> register(String username, String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null, registrationSuccess: false);
    try {
      await _authRepository.register(username, email, password);
      state = state.copyWith(isLoading: false, registrationSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final registerViewModelProvider =
StateNotifierProvider<RegisterViewModel, RegisterState>((ref) {
  return RegisterViewModel(AuthRepository());
});
