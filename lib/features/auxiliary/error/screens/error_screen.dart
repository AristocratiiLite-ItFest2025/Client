import 'package:flutter/material.dart';

import '../../../../shared/widgets/top_app_bar.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(),
      body: const Center(child: Text("Error: Something went wrong")),
    );
  }
}