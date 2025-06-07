import 'dart:convert';

import 'package:booknstyle/core/error/failures.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';

// If baseUrl is not defined in strings.dart, define it here or ensure it's exported from there.
// Example definition (remove if already defined in strings.dart):
// const String baseUrl = 'https://your-api-base-url.com';
import '../../../domain/usecases/user/sign_in_user_usecase.dart';
import '../../../domain/usecases/user/sign_up_user_usecase.dart';
import '../../models/user/authentication_response_model.dart';

// Define baseUrl if not already imported from strings.dart
const String baseUrl = 'https://vxgzdtwh-5001.inc1.devtunnels.ms';

abstract class UserRemoteDataSource {
  Future<AuthenticationResponseModel> signIn(SignInParams params);
  Future<AuthenticationResponseModel> signUp(SignUpParams params);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthenticationResponseModel> signIn(SignInParams params) async {
    final response = await client.post(
      Uri.parse('$baseUrl/authentication/local/sign-in'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'identifier': params.username,
        'password': params.password,
      }),
    );
    if (response.statusCode == 200) {
      return authenticationResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AuthenticationResponseModel> signUp(SignUpParams params) async {
    final response = await client.post(
      Uri.parse('$baseUrl/api/Users/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Access-Control-Allow-Origin': '*/*',
        'Access-Control-Allow-Methods': 'POST, GET, PUT, DELETE',
      },
      body: json.encode({
        'email': params.email,
        'password': params.password,
      }),
    );
    if (response.statusCode == 201) {
      return authenticationResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerException();
    }
  }
}
