import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/entry_model.dart';

final baseUrl = 'https://backend-helpnow.city-aura.co';

class EntryService {
  final String baseUrl;
  EntryService({required this.baseUrl});

  Future<EntryModel> sendEntry(EntryModel entry) async {
    final url = Uri.parse('$baseUrl/entries');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(entry.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return EntryModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to send entry');
    }
  }

  Future<List<EntryModel>> fetchEntries(int chatId) async {
    final url = Uri.parse('$baseUrl/entries/$chatId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      debugPrint("fml");
      debugPrint(response.body.toString());
      return jsonData.map((json) => EntryModel.fromJson(json)).toList();
    } else {
      debugPrint("fml");
      debugPrint(response.body.toString());
      throw Exception('Failed to fetch entries');
    }
  }
}

final entryServiceProvider = Provider<EntryService>((ref) {
  return EntryService(baseUrl: baseUrl);
});
