import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_now_frontend/core/constants/app_constants.dart';
import 'package:help_now_frontend/core/enums/app_screen.dart';
import 'package:help_now_frontend/core/navigation/navigation_manager.dart';

class TopAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});

  /// Determines whether to show a back arrow for the given screen.
  bool _shouldShowBackButton(AppScreen screen) {
    return screen == AppScreen.entryList ||
        screen == AppScreen.settings ||
        screen == AppScreen.profile ||
        screen == AppScreen.error;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentScreen = ref.watch(navigationManagerProvider);
    final bool showBackButton = _shouldShowBackButton(currentScreen);

    return AppBar(
      title: Text(_getScreenTitle(currentScreen)),
      centerTitle: true,
      elevation: 4.0,
      // Conditionally render the leading widget.
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          // Update the navigation state to go back (e.g. to ChatList)
          ref
              .read(navigationManagerProvider.notifier)
              .navigateTo(AppScreen.chatList);
        },
      )
          : Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {
            ref
                .read(navigationManagerProvider.notifier)
                .navigateTo(AppScreen.profile);
          },
          iconSize: 28.0,
          color: currentScreen == AppScreen.profile
              ? Theme.of(context).colorScheme.secondary
              : Colors.grey,
        ),
      ),
      // Remove the actions for the back arrow screens.
      actions: showBackButton
          ? null
          : [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              ref
                  .read(navigationManagerProvider.notifier)
                  .navigateTo(AppScreen.settings);
            },
            iconSize: 28.0,
            color: currentScreen == AppScreen.settings
                ? Theme.of(context).colorScheme.secondary
                : Colors.grey,
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
      case AppScreen.entryList:
        return "Chat";
      case AppScreen.error:
        return "Error";
      default:
        return AppConstants.appName;
    }
  }
}
