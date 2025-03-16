import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/enums/app_screen.dart';
import '../../core/constants/app_constants.dart';
import '../../core/navigation/navigation_manager.dart';

/// A web-specific top bar that shows a logo, navigation links, and account actions.
class WebTopBar extends ConsumerWidget implements PreferredSizeWidget {
  const WebTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navState = ref.watch(navigationManagerProvider);
    final currentScreen = navState.screen;
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 4.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Logo and App Name
          Row(
            children: [
              Icon(Icons.web, size: 32, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text(
                AppConstants.appName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          // Center: Navigation Links
          Row(
            children: [
              _NavLink(
                label: "Search",
                icon: Icons.search,
                isSelected: currentScreen == AppScreen.search,
                onTap: () => ref
                    .read(navigationManagerProvider.notifier)
                    .navigateTo(AppScreen.search),
              ),
              _NavLink(
                label: "Map",
                icon: Icons.map,
                isSelected: currentScreen == AppScreen.map,
                onTap: () => ref
                    .read(navigationManagerProvider.notifier)
                    .navigateTo(AppScreen.map),
              ),
              _NavLink(
                label: "Chats",
                icon: Icons.chat,
                isSelected: currentScreen == AppScreen.chatList,
                onTap: () => ref
                    .read(navigationManagerProvider.notifier)
                    .navigateTo(AppScreen.chatList),
              ),
            ],
          ),
          // Right: Profile and Settings
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: () => ref
                    .read(navigationManagerProvider.notifier)
                    .navigateTo(AppScreen.profile),
                iconSize: 28.0,
                color: currentScreen == AppScreen.profile
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.grey,
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => ref
                    .read(navigationManagerProvider.notifier)
                    .navigateTo(AppScreen.settings),
                iconSize: 28.0,
                color: currentScreen == AppScreen.settings
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// A reusable widget for web navigation links.
class _NavLink extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color =
    isSelected ? Theme.of(context).colorScheme.secondary : Colors.grey;
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: color),
      label: Text(
        label,
        style: TextStyle(color: color),
      ),
    );
  }
}
