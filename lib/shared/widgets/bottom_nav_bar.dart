import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/enums/app_screen.dart';
import '../../core/navigation/navigation_manager.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentScreen = ref.watch(navigationManagerProvider);
    final navigationManager = ref.read(navigationManagerProvider.notifier);
    final theme = Theme.of(context).colorScheme; // Fetch theme colors

    return BottomAppBar(
      color: theme.primaryContainer, // Themed background color
      elevation: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Left button: Search screen.
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => navigationManager.navigateTo(AppScreen.search),
            color: currentScreen == AppScreen.search
                ? theme.secondary // Highlight active icon
                : theme.onPrimaryContainer.withAlpha(153), // Dim inactive icon
          ),
          // Center button: Map screen.
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () => navigationManager.navigateTo(AppScreen.map),
            color: currentScreen == AppScreen.map
                ? theme.secondary
                : theme.onPrimaryContainer.withAlpha(153),
          ),
          // Right button: NGO Chat screen.
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () => navigationManager.navigateTo(AppScreen.chatList),
            color: currentScreen == AppScreen.chatList
                ? theme.secondary
                : theme.onPrimaryContainer.withAlpha(153),

          ),
        ],
      ),
    );
  }
}
