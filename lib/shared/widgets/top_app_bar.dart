import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_now_frontend/core/constants/app_constants.dart';

import '../../core/enums/app_screen.dart';
import '../../core/navigation/navigation_manager.dart';

class TopAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentScreen = ref.watch(navigationManagerProvider);

    return AppBar(
      title: Text(_getScreenTitle(currentScreen)),
      centerTitle: true,
      elevation: 4.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  /// Returns a human-readable title based on the screen.
  String _getScreenTitle(AppScreen screen) {
    switch (screen) {
      case AppScreen.login:
        return "Login";
      case AppScreen.register:
        return "Register";
      case AppScreen.settings:
        return "Settings";
      case AppScreen.profile:
        return "Profile";
      case AppScreen.error:
        return "Error";
      default:
        return AppConstants.appName;
    }
  }
}
