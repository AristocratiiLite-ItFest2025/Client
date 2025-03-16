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
    final theme = Theme.of(context).colorScheme; // Fetch theme colors

    return AppBar(
      backgroundColor: theme.primary, // Set app bar color
      title: Text(
        _getScreenTitle(currentScreen),
        style: TextStyle(
          color: theme.onPrimary, // Text color based on theme
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      elevation: 4.0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0), // Adjust padding
        child: IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {
            ref.read(navigationManagerProvider.notifier).navigateTo(AppScreen.profile);
          },
          iconSize: 28.0,
          color: currentScreen == AppScreen.profile
              ? theme.secondary // Highlight active icon
              : theme.onPrimary.withAlpha(153), // Dim inactive icon
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0), // Adjust padding
          child: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              ref.read(navigationManagerProvider.notifier).navigateTo(AppScreen.settings);
            },
            iconSize: 28.0,
            color: currentScreen == AppScreen.settings
                ? theme.secondary // Highlight active icon
                : theme.onPrimary.withAlpha(153), // Dim inactive icon
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
      case AppScreen.error:
        return "Error";
      default:
        return AppConstants.appName;
    }
  }
}
