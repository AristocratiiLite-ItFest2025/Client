import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/enums/app_screen.dart';
import '../../../../core/navigation/navigation_manager.dart';
import '../view_models/register_vm.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    ref.read(registerViewModelProvider.notifier).register(username, email, password);
  }

  void _navigateBack() {
    ref.read(navigationManagerProvider.notifier).navigateTo(AppScreen.login);
  }

  @override
  Widget build(BuildContext context) {
    // Listen for a successful registration.
    ref.listen<RegisterState>(registerViewModelProvider, (previous, next) {
      if (next.registrationSuccess && (previous?.registrationSuccess != true)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registered successfully!')),
        );
        // Delay a moment so the user sees the SnackBar, then navigate to login.
        Future.delayed(const Duration(seconds: 1), () {
          ref.read(navigationManagerProvider.notifier).navigateTo(AppScreen.login);
        });
      }
    });

    final registerState = ref.watch(registerViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _navigateBack,
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Username field
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                // Email field
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                // Password field
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                // Register button or loading indicator
                registerState.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _onRegister,
                  child: const Text("Register"),
                ),
                // Display error message if any
                if (registerState.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      registerState.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
