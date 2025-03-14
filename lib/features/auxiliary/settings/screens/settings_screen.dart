import 'package:flutter/material.dart';

import '../../../../shared/widgets/top_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(),
      body: const Center(child: Text("Settings Screen Mockup")),
    );
  }
}