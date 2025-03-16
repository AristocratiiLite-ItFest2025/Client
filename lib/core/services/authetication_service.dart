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

    // Decode the JSON response.
    final responseData = jsonDecode(response.body);
    // Extract the user id and username from the response.
    final int userId = responseData['id'];
    final String usernameFromResponse = responseData['username'];

    // Store both user id and username locally.
    await PreferencesService().setUserId(userId);
    await PreferencesService().setUsername(usernameFromResponse);
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

    // Decode the JSON response.
    final responseData = jsonDecode(response.body);
    // Extract the user id and username from the response.
    final int userId = responseData['id'];
    final String usernameFromResponse = responseData['username'];

    // Optionally store both user id and username locally.
    await PreferencesService().setUserId(userId);
    await PreferencesService().setUsername(usernameFromResponse);
  }
}
