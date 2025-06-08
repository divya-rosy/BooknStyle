import 'package:booknstyle/presentation/widgets/input_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booknstyle/domain/entities/user_info/user_profile.dart';
import 'package:booknstyle/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'package:booknstyle/presentation/blocs/user_profile/user_profile_state.dart';
import 'package:booknstyle/presentation/blocs/user_profile/user_profile_event.dart';
import 'package:booknstyle/presentation/widgets/input_form_button.dart';
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
    context.read<UserProfileBloc>().add(FetchUserProfile());
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
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
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
    );
  }

  Widget _buildProfile(BuildContext context, UserProfile userProfile) {
    _dateController.text = userProfile.dateOfBirth.toIso8601String().split(
      'T',
    )[0];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'First Name: ${userProfile.firstName}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            'Last Name: ${userProfile.lastName}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            'Phone Number: ${userProfile.phoneNumber}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          InputTextFormField(
            controller: _dateController,
            hint: 'Date of Birth',
            enable: true,
            readOnly: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            suffixIcon: const Icon(Icons.calendar_today, color: Colors.black87),
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
                });
                final updatedProfile = userProfile.copyWith(dateOfBirth: selectedDate);
                context.read<UserProfileBloc>().add(SaveUserProfile(updatedProfile));
              }
            },
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 16),
          InputFormButton(
            onClick: () {
              context.read<UserProfileBloc>().add(SaveUserProfile(userProfile));
              Navigator.pushNamed(context, AppRouter.addressForm);
            },
            titleText: 'Continue',
            cornerRadius: 12.0,
            textStyle: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}