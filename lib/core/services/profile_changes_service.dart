import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ProfileChangesService {
  final baseUrl = 'https://backend-helpnow.city-aura.co';

  ProfileChangesService();

  Future<Map<String, dynamic>> updateUserVerification({
    required int userId,
    required String isVerified,
  }) async {
    final validStatuses = ['NGO', 'SPONSOR', 'PERSON'];

    if (!validStatuses.contains(isVerified)) {
      throw Exception(
          "Invalid verification status. Must be one of: ${validStatuses.join(', ')}");
    }

    final url = Uri.parse('$baseUrl/users/$userId/update-verification');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'isVerified': isVerified}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final Map<String, dynamic> error = jsonDecode(response.body);
      throw Exception('Error: ${error['error']}');
    }
  }
}
final profileChangesServiceProvider = Provider<ProfileChangesService>((ref) {
  return ProfileChangesService();
});
