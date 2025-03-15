import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_now_frontend/core/constants/app_constants.dart';
import 'package:help_now_frontend/core/enums/app_screen.dart';
import 'package:help_now_frontend/core/navigation/navigation_manager.dart';

class TopAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentScreen = ref.watch(navigationManagerProvider);

    return AppBar(
      title: Text(_getScreenTitle(currentScreen)),
      centerTitle: true,
      elevation: 4.0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0), // Adjusting padding for the left icon
        child: IconButton(
          icon: const Icon(Icons.account_circle), // Account icon
          onPressed: () {
            // Navigate to the account management page
            ref.read(navigationManagerProvider.notifier).navigateTo(AppScreen.profile);
          },
          iconSize: 28.0, // Adjusting icon size
          color: currentScreen == AppScreen.profile ? Theme.of(context).colorScheme.secondary : Colors.grey, // Adjusting color based on screen
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0), // Adjusting padding for the right icon
          child: IconButton(
            icon: const Icon(Icons.settings), // Gear icon
            onPressed: () {
              // Navigate to the settings page
              Navigator.pushNamed(context, '/settings'); // Ensure '/settings' matches the route name
            },
            iconSize: 28.0, // Adjusting icon size
            color: currentScreen == AppScreen.settings ? Theme.of(context).colorScheme.secondary : Colors.grey, // Adjusting color based on screen
          ),
        ),
      ],
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
      case AppScreen.chat:
        return "Chat";
      case AppScreen.error:
        return "Error";
      default:
        return AppConstants.appName;
    }
  }
}
