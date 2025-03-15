import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/app_screen.dart';

/// Riverpod provider for the NavigationManager.
final navigationManagerProvider =
StateNotifierProvider<NavigationManager, AppScreen>(
      (ref) => NavigationManager(),
);

/// NavigationManager handles the current screen state.
class NavigationManager extends StateNotifier<AppScreen> {
  NavigationManager() : super(AppScreen.login); //Todo: Change to login

  /// Change the current screen.
  void navigateTo(AppScreen screen) {
    state = screen;
  }
}