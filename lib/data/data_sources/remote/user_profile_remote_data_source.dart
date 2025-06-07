import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/error/exceptions.dart';
import 'package:booknstyle/data/models/user_profile/user_profile_model.dart'; // Import the UserProfileModel

abstract class UserProfileRemoteDataSource {
  Future<UserProfileModel> getUserProfile();
    Future<void> saveUserProfile(UserProfileModel userProfile); // Add this method

}

const String baseUrl = 'https://vxgzdtwh-5001.inc1.devtunnels.ms'; // Replace with your actual base URL

class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  final http.Client client;

  UserProfileRemoteDataSourceImpl({required this.client});

  @override
  Future<UserProfileModel> getUserProfile() async {
    final response = await client.get(
      Uri.parse('$baseUrl/api/UserDetails'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return UserProfileModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> saveUserProfile(UserProfileModel userProfile) async {
    final response = await client.post(
      Uri.parse('$baseUrl/api/UserDetails'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userProfile.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ServerException();
    }
  }
}