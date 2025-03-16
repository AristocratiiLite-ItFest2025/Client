import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_now_frontend/core/enums/is_verified.dart';
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

  /// Save the complete profile.
  Future<bool> setProfile(ProfileModel profile) async {
    if (_prefs == null) await init();
    final jsonString = jsonEncode(profile.toJson());
    return _prefs!.setString('profile', jsonString);
  }

  /// Retrieve the complete profile.
  ProfileModel? get profile {
    final jsonString = _prefs?.getString('profile');
    if (jsonString == null) return null;
    return ProfileModel.fromJson(jsonDecode(jsonString));
  }

  /// Update only the verifiedType in profile.
  Future<bool> updateVerifiedType(IsVerified newType) async {
    if (_prefs == null) await init();
    final currentProfile = profile;
    if (currentProfile == null) return false;

    final updatedProfile = ProfileModel(
      avatarImage: currentProfile.avatarImage,
      money: currentProfile.money,
      email: currentProfile.email,
      verifiedType: newType,
      username: currentProfile.username,
      id: currentProfile.id,
    );

    return setProfile(updatedProfile);
  }
}

// Provider stays the same
final preferencesServiceProvider = FutureProvider<PreferencesService>((ref) async {
  final service = PreferencesService();
  await service.init();
  return service;
});
