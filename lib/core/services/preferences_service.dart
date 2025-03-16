import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile_model.dart';

class PreferencesService {
  static final PreferencesService _instance = PreferencesService._internal();
  SharedPreferences? _prefs;

  factory PreferencesService() => _instance;
  PreferencesService._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save the complete profile as a JSON string.
  Future<bool> setProfile(ProfileModel profile) async {
    if (_prefs == null) await init();
    final jsonString = jsonEncode(profile.toJson());
    return _prefs!.setString('profile', jsonString);
  }

  // Retrieve the complete profile.
  ProfileModel? get profile {
    final jsonString = _prefs?.getString('profile');
    if (jsonString == null) return null;
    return ProfileModel.fromJson(jsonDecode(jsonString));
  }
}
final preferencesServiceProvider =
FutureProvider<PreferencesService>((ref) async {
  final service = PreferencesService();
  await service.init();
  return service;
});