import 'package:flutter/material.dart';

import '../../../../shared/widgets/top_app_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(),
      body: const Center(child: Text("Login Screen Mockup")),
    );
  }
}