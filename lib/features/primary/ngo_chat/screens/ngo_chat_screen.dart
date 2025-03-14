import 'package:flutter/material.dart';

class NgoChatScreen extends StatelessWidget {
  const NgoChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NGO Chat")),
      body: const Center(child: Text("NGO Chat Screen Mockup")),
    );
  }
}