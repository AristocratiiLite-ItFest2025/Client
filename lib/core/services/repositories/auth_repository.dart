import '../authetication_service.dart';

class AuthRepository {
  final AuthenticationService _authService = AuthenticationService();

  Future<void> register(String username, String email, String password) async {
    await _authService.register(username, email, password);
  }

  Future<void> login(String username, String password) async {
    await _authService.login(username, password);
  }
}
