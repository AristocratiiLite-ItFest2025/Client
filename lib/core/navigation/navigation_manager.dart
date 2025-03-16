import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/app_screen.dart';

/// Riverpod provider for the NavigationManager.
final navigationManagerProvider =
StateNotifierProvider<NavigationManager, AppScreen>(
      (ref) => NavigationManager(),
);

/// NavigationManager handles the current screen state.
class NavigationManager extends StateNotifier<AppScreen> {
  // Stack to store navigation history.
  final List<AppScreen> _screenHistory = [];

  NavigationManager() : super(AppScreen.login);

  /// Navigates to a new screen while saving the current screen in history.
  void navigateTo(AppScreen screen) {
    _screenHistory.add(state);
    state = screen;
  }

  /// Navigates back to the previous screen if available.
  void navigateBack() {
    if (_screenHistory.isNotEmpty) {
      state = _screenHistory.removeLast();
    } else {
      state = AppScreen.map;
    }
  }
}
