import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_now_frontend/shared/widgets/top_app_bar.dart';


class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const TopAppBar(),
      body: const Center(child: Text("Settings Screen Mockup")),
    );
  }
}
