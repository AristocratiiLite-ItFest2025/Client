import 'dart:convert';
import 'package:http/http.dart' as http;
import 'preferences_service.dart';

class AuthenticationService {
  final String baseUrl = 'https://backend-helpnow.city-aura.co';

  Future<void> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Login failed: ${response.body}');
    }

    // Store username locally upon successful login.
    await PreferencesService().setUsername(username);
  }

  Future<void> register(String username, String email, String password) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'isVerified': 'PERSON',
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Registration failed: ${response.body}');
    }
  }
}
