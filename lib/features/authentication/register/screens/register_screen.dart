import 'package:flutter/material.dart';

import '../../../../shared/widgets/top_app_bar.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(),
      body: const Center(child: Text("Register Screen Mockup")),
    );
  }
}