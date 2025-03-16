import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/preferences_service.dart';
import '../../../../shared/widgets/top_app_bar.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPrefs = ref.watch(preferencesServiceProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const TopAppBar(),
      body: asyncPrefs.when(
        data: (prefsService) {
          final username = prefsService.username ?? 'Guest';
          return Center(
            child: Text(
              "Profile Screen - Welcome, $username",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: colorScheme.onSurface),
            ),
          );
        },
        loading: () => Center(
          child: CircularProgressIndicator(
            color: colorScheme.primary, // Adaptive loading color
          ),
        ),
        error: (error, stack) => Center(
          child: Text(
            "Error: $error",
            style: TextStyle(color: colorScheme.error, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
