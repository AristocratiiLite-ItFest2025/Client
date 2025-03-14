import 'package:flutter/material.dart';

import '../../../../shared/widgets/top_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(),
      body: const Center(child: Text("Profile Screen Mockup")),
    );
  }
}
