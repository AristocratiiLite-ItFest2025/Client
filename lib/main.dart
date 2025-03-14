import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/theme.dart';
import 'core/navigation/navigation_manager.dart';
import 'core/navigation/screen_list.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentScreen = ref.watch(navigationManagerProvider);

    return MaterialApp(
      title: 'My Flutter App',
      theme: buildAppTheme(),
      home: getScreenWidget(currentScreen),
    );
  }
}