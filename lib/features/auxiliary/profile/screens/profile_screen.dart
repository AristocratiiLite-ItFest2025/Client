import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/preferences_service.dart';
import '../../../../shared/widgets/top_app_bar.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPrefs = ref.watch(preferencesServiceProvider);

    return Scaffold(
      appBar: const TopAppBar(),
      body: asyncPrefs.when(
        data: (prefsService) {
          final username = prefsService.username ?? 'Guest';
          return Center(
            child: Text(
              "Profile Screen - Welcome, $username",
              style: const TextStyle(fontSize: 20),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text("Error: $error")),
      ),
    );
  }
}
