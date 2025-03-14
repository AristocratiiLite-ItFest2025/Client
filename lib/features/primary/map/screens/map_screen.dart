import 'package:flutter/material.dart';

import '../../../../shared/widgets/bottom_nav_bar.dart';
import '../../../../shared/widgets/top_app_bar.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(),
      body: const Center(child: Text("Map Screen Mockup")),
      bottomNavigationBar: const BottomNavBar()
    );
  }
}