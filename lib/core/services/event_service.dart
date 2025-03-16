import 'dart:convert';
import 'package:flutter/cupertino.dart';
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
      throw Exception("Error fetching events: $e");
    }
  }

  Future<EventModel> createEvent(EventModel event) async {
    try {
      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(event.toJson()),
      );

      debugPrint(response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        return EventModel.fromJson(data);
      } else {
        throw Exception(
            "Failed to create event. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error creating event: $e");
    }
  }
}
