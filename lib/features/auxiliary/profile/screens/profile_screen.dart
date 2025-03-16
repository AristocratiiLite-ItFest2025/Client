import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_now_frontend/core/enums/is_verified.dart';
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

class ProfileContent extends ConsumerStatefulWidget {
  final ProfileModel profile;

  const ProfileContent({super.key, required this.profile});

  @override
  ConsumerState<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends ConsumerState<ProfileContent> {
  final List<IsVerified> _statuses = [IsVerified.NGO, IsVerified.SPONSOR, IsVerified.PERSON];
  late IsVerified _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.profile.verifiedType;
  }

  @override
  Widget build(BuildContext context) {
    final profileVm = ref.read(profileViewModelProvider.notifier);

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        if (widget.profile.avatarImage != null)
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.profile.avatarImage!),
            ),
          ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            "Username: ${widget.profile.username}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            "Email: ${widget.profile.email}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            "Money: \$${widget.profile.money}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 16),
        const Text("Change Verification Type:"),
        const SizedBox(height: 8),
        DropdownButtonFormField<IsVerified>(
          value: _selectedStatus,
          items: _statuses
              .map((status) => DropdownMenuItem<IsVerified>(
            value: status,
            child: Text(status.name), // assuming you use .name to display enum names
          ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedStatus = value;
              });
            }
          },
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            await profileVm.updateVerification(widget.profile.id, _selectedStatus);
          },
          child: const Text("Update Verification"),
        ),
      ],
    );
  }
}
