import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';

class EventService {
  final String _endpoint = "https://backend-helpnow.city-aura.co/events";

  Future<List<EventModel>> fetchEvents() async {
    try {
      final response = await http.get(
        Uri.parse(_endpoint),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => EventModel.fromJson(json)).toList();
      } else {
        throw Exception(
            "Failed to load events. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // Log error details if needed
      throw Exception("Error fetching events: $e");
    }
  }
}
