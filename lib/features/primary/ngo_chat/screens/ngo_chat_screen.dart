import 'package:flutter/material.dart';

import '../../../../shared/widgets/bottom_nav_bar.dart';
import '../../../../shared/widgets/top_app_bar.dart';

class NgoChatScreen extends StatelessWidget {
  const NgoChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(),
      body: const Center(child: Text("NGO Chat Screen Mockup")),
      bottomNavigationBar: const BottomNavBar()
    );
  }
}