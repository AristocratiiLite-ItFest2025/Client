import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/navigation/navigation_manager.dart';
import '../core/navigation/screen_list.dart';


class AppRouter extends ConsumerWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentScreen = ref.watch(navigationManagerProvider);
    return Scaffold(
      body: getScreenWidget(currentScreen),
    );
  }
}