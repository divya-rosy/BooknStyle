// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../core/constant/app_sizes.dart';
import '../../../core/constant/images.dart';
import '../../../core/constant/validators.dart';
import 'package:booknstyle/presentation/views/user_info/user_profile_view.dart';
import '../../../domain/usecases/user/sign_up_user_usecase.dart';
import '../../blocs/user/user_bloc.dart';
import '../../widgets/input_form_button.dart';
import '../../widgets/input_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSignUpEnabled = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePasswords);
    _confirmPasswordController.addListener(_validatePasswords);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_validatePasswords);
    _confirmPasswordController.removeListener(_validatePasswords);
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validatePasswords() {
    setState(() {
      _isSignUpEnabled =
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _passwordController.text == _confirmPasswordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        EasyLoading.dismiss();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingMedium),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    SizedBox(
                      height: 80,
                      child: Image.asset(kAppLogo, color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Please use your e-mail address to create a new account",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    InputTextFormField(
                      controller: _emailController,
                      hint: 'Email',
                      textInputAction: TextInputAction.next,
                      validation: (String? val) =>
                          Validators.validateEmail(val),
                    ),
                    const SizedBox(height: 12),
                    InputTextFormField(
                      controller: _passwordController,
                      hint: 'Password',
                      textInputAction: TextInputAction.next,
                      isSecureField: true,
                      validation: (String? val) =>
                          Validators.validateField(val, "Password"),
                    ),
                    const SizedBox(height: 12),
                    InputTextFormField(
                      controller: _confirmPasswordController,
                      hint: 'Confirm Password',
                      isSecureField: true,
                      textInputAction: TextInputAction.go,
                      validation: (String? val) =>
                          Validators.validatePasswordMatch(
                            val,
                            _passwordController.text,
                          ),
                      onFieldSubmitted: (_) => _onSignUp(context),
                    ),
                    const SizedBox(height: 24),
                    // Conditionally render the Sign Up button
                    if (_isSignUpEnabled)
                      InputFormButton(
                        color: Colors.black87,
                        onClick: () {
                          if (_formKey.currentState!.validate()) {
                            EasyLoading.show(status: 'Signing up...');
                            _onSignUp(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserProfilePage(),
                              ),
                            );
                          }
                        },
                        titleText: 'Sign Up',
                      ),
                    const SizedBox(height: 10),
                    InputFormButton(
                      color: Colors.black87,
                      onClick: () {
                        Navigator.of(context).pop();
                      },
                      titleText: 'Back',
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSignUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<UserBloc>().add(
        SignUpUser(
          SignUpParams(
            email: _emailController.text,
            password: _passwordController.text,
          ),
        ),
      );
    }
  }
}
