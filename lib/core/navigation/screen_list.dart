import 'package:flutter/material.dart';

import '../../features/authentication/login/screens/login_screen.dart';
import '../../features/authentication/register/screens/register_screen.dart';
import '../../features/auxiliary/error/screens/error_screen.dart';
import '../../features/auxiliary/profile/screens/profile_screen.dart';
import '../../features/auxiliary/settings/screens/settings_screen.dart';
import '../../features/primary/chat_list/screens/chat_list_screen.dart';
import '../../features/primary/event_list/screen/event_list_screen.dart';
import '../../features/primary/map/screens/map_screen.dart';
import '../../features/primary/chat/screens/entry_list_screen.dart';

import '../enums/app_screen.dart';
import 'navigation_manager.dart';

/// Returns the widget corresponding to the given [screen].
Widget getScreenWidget(NavigationState navState) {
  switch (navState.screen) {
    case AppScreen.login:
      return const LoginScreen();
    case AppScreen.register:
      return const RegisterScreen();
    case AppScreen.search:
      return const EventListScreen();
    case AppScreen.map:
      return const MapScreen();
    case AppScreen.chatList:
      return const ChatListScreen();
    case AppScreen.entryList:
    // Retrieve the chat id passed in the navigation state.
      final chatId = navState.arguments as int?;
      return EntryListScreen(chatId: chatId ?? 1);
    case AppScreen.settings:
      return const SettingsScreen();
    case AppScreen.profile:
      return const ProfileScreen();
    case AppScreen.error:
      return const ErrorScreen();
  }
}

