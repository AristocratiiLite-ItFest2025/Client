import '../../models/profile_model.dart';
import '../authetication_service.dart';

class AuthRepository {
  final AuthenticationService _authService = AuthenticationService();

  Future<void> register(String username, String email, String password) async {
    await _authService.register(username, email, password);
  }

  Future<ProfileModel> login(String username, String password) async {
    return await _authService.login(username, password);
  }
}
