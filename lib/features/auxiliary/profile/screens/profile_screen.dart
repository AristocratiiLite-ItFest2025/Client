import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/profile_model.dart';
import '../../../../shared/widgets/top_app_bar.dart';
import '../view_models/profile_vm.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProfile = ref.watch(profileViewModelProvider);

    return Scaffold(
      appBar: const TopAppBar(),
      // Only wrap the body with the light theme
      body: Theme(
        data: ThemeData.light(),
        child: asyncProfile.when(
          data: (profile) => profile != null
              ? ProfileContent(profile: profile)
              : const Center(child: Text("No profile data available")),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, st) => Center(child: Text("Error: $error")),
        ),
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  final ProfileModel profile;

  const ProfileContent({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        if (profile.avatarImage != null)
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(profile.avatarImage!),
            ),
          ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            "Username: ${profile.username}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            "Email: ${profile.email}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            "Money: \$${profile.money}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            "Verified: ${profile.verifiedType.toString().split('.').last}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
