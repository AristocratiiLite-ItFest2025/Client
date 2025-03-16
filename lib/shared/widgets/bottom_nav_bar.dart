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

    return BottomAppBar(
      elevation: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Left button: Search screen.
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => navigationManager.navigateTo(AppScreen.search),
            color: currentScreen == AppScreen.search
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.secondaryContainer,
          ),
          // Center button: Map screen.
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () => navigationManager.navigateTo(AppScreen.map),
            color: currentScreen == AppScreen.map
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.secondaryContainer,
          ),
          // Right button: NGO Chat screen.
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () => navigationManager.navigateTo(AppScreen.chatList),
            color: currentScreen == AppScreen.chatList
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.secondaryContainer,
          ),
        ],
      ),
    );
  }
}
