import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/enums/app_screen.dart';
import '../../../../core/navigation/navigation_manager.dart';
import '../view_models/login_vm.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    ref.read(loginViewModelProvider.notifier).login(email, password);
  }

  void _navigateToRegister() {
    ref.read(navigationManagerProvider.notifier).navigateTo(AppScreen.register);
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginViewModelProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Email field
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                // Password field
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                // Login button or loading indicator
                loginState.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _onLogin,
                  child: const Text("Login"),
                ),
                // Display error message if any
                if (loginState.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      loginState.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 20),
                // Button to navigate to register screen
                TextButton(
                  onPressed: _navigateToRegister,
                  child: const Text("Don't have an account? Register here."),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
