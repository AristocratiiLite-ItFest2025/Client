import 'dart:async';

class AuthenticationService {
  Future<void> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    // TODO: Implement proper authentication logic.
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password cannot be empty.');
    }
    return;
  }

  Future<void> register(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    // TODO: Implement proper registration logic.
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password cannot be empty.');
    }
    return;
  }
}
