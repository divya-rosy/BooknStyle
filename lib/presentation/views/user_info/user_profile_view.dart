import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booknstyle/domain/entities/user_info/user_profile.dart';
import 'package:booknstyle/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'package:booknstyle/presentation/blocs/user_profile/user_profile_state.dart';
import 'package:booknstyle/presentation/blocs/user_profile/user_profile_event.dart';
import 'package:booknstyle/domain/usecases/user_info/get_user_profile.dart';
import 'package:booknstyle/domain/usecases/user_info/save_user_profile.dart' as usecase;
import 'package:booknstyle/core/router/app_router.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: BlocProvider(
        create: (context) => UserProfileBloc(
          getUserProfile: context.read<GetUserProfileUseCase>(),
          saveUserProfile: context.read<usecase.SaveUserProfileUseCase>(),
        )..add(FetchUserProfile()),
        child: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserProfileLoaded) {
              return _buildProfile(context, state.userProfile);
            } else if (state is UserProfileError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: Text('Please wait...'));
          },
        ),
      ),
    );
  }

  Widget _buildProfile(BuildContext context, UserProfile userProfile) {
    _dateController.text = userProfile.dateOfBirth.toIso8601String().split('T')[0];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('First Name: ${userProfile.firstName}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          Text('Last Name: ${userProfile.lastName}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          Text('Phone Number: ${userProfile.phoneNumber}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          TextField(
            controller: _dateController,
            readOnly: true,
            decoration: const InputDecoration(
              labelText: 'Date of Birth',
              border: OutlineInputBorder(),
            ),
            onTap: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: userProfile.dateOfBirth,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (selectedDate != null) {
                setState(() {
                  _dateController.text = selectedDate.toIso8601String().split('T')[0];
                  userProfile = userProfile.copyWith(dateOfBirth: selectedDate);
                });
              }
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<UserProfileBloc>().add(SaveUserProfile(userProfile));
              Navigator.pushNamed(context, AppRouter.addressForm);
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}