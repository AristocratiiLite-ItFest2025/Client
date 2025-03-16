import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/chat_model.dart';

final baseUrl = 'https://backend-helpnow.city-aura.co';

class ChatService {
  final String baseUrl;
  ChatService({required this.baseUrl});

  // Fetch all chats for a given user.
  Future<List<ChatModel>> fetchChats(int userId) async {
    final url = Uri.parse('$baseUrl/chats?user_id=$userId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ChatModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load chats');
    }
  }
}

final chatServiceProvider = Provider<ChatService>((ref) {
  return ChatService(baseUrl: baseUrl);
});
