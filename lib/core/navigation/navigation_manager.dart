import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/app_screen.dart';

class NavigationState {
  final AppScreen screen;
  final dynamic arguments; // Use dynamic or a specific type if you know what to expect.

  NavigationState({required this.screen, this.arguments});
}

/// Update your provider accordingly:
final navigationManagerProvider = StateNotifierProvider<NavigationManager, NavigationState>(
      (ref) => NavigationManager(),
);


/// NavigationManager handles the current screen state.
class NavigationManager extends StateNotifier<NavigationState> {
  final List<NavigationState> _screenHistory = [];

  NavigationManager() : super(NavigationState(screen: AppScreen.login));

  /// Navigates to a new screen while saving the current screen in history.
  void navigateTo(AppScreen screen, {dynamic arguments}) {
    _screenHistory.add(state);
    state = NavigationState(screen: screen, arguments: arguments);
  }

  /// Navigates back to the previous screen if available.
  void navigateBack() {
    if (_screenHistory.isNotEmpty) {
      state = _screenHistory.removeLast();
    } else {
      state = NavigationState(screen: AppScreen.map);
    }
  }
}

