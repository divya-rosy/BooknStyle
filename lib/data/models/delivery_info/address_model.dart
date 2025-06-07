import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/error/exceptions.dart';

// Define AddressModel if it does not exist
class AddressModel {
  // Add your fields here
  final String userId;
  final String addressId; // Assuming you have a userId field
  final String street;
  final String city;
  final String? state;
  final String? postalCode;
  final String? country;
  final bool isBilling;

  AddressModel({
    required this.userId, // Include userId in the constructor
    required this.addressId, // Default value for addressId
    required this.street,
    required this.city,
    required this.isBilling,
    this.state,
    this.postalCode,
    this.country,
  });
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      userId: json['userId'] as String,
      addressId: json['addressId'] as String, // Assuming userId is part of the JSON
      street: json['street'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postalCode'],
      country: json['country'],
      isBilling: json['isBilling'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId, // Include userId in the JSON
    'street': street,
    'city': city,
    'state': state,
    'postalCode': postalCode,
    'country': country,
    'isBilling': isBilling,
  };
}

abstract class AddressRemoteDataSource {
  Future<void> saveAddress(AddressModel address);
}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final http.Client client;

  AddressRemoteDataSourceImpl({required this.client});

  @override
  Future<void> saveAddress(AddressModel address) async {
    final response = await client.post(
      Uri.parse('https:'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(address.toJson()),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }
}
