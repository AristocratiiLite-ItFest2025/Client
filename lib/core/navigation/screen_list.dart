import 'package:flutter/material.dart';

import '../../features/primary/chat_list/screens/chat_list_screen.dart';
import '../../features/primary/event_list/screen/event_list_screen.dart';
import '../enums/app_screen.dart';

import '../../features/authentication/login/screens/login_screen.dart';
import '../../features/authentication/register/screens/register_screen.dart';
import '../../features/auxiliary/error/screens/error_screen.dart';
import '../../features/auxiliary/profile/screens/profile_screen.dart';
import '../../features/auxiliary/settings/screens/settings_screen.dart';
import '../../features/primary/map/screens/map_screen.dart';

/// Returns the widget corresponding to the given [screen].
Widget getScreenWidget(AppScreen screen) {
  switch (screen) {
    case AppScreen.login:
      return const LoginScreen();
    case AppScreen.register:
      return const RegisterScreen();
    case AppScreen.search:
      return const SearchScreen();
    case AppScreen.map:
      return const MapScreen();
    case AppScreen.chat:
      return const ChatListScreen();
    case AppScreen.settings:
      return const SettingsScreen();
    case AppScreen.profile:
      return const ProfileScreen();
    case AppScreen.error:
    return const ErrorScreen();
  }
}
