import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static final PreferencesService _instance = PreferencesService._internal();
  SharedPreferences? _prefs;

  factory PreferencesService() => _instance;
  PreferencesService._internal();

  /// Must be called at the app startup.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String? get username => _prefs?.getString('username');

  Future<bool> setUsername(String username) async {
    if (_prefs == null) {
      await init();
    }
    return _prefs!.setString('username', username);
  }
}

final preferencesServiceProvider = FutureProvider<PreferencesService>((ref) async {
  final service = PreferencesService();
  await service.init();
  return service;
});
