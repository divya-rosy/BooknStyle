import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/error/exceptions.dart';
import 'package:booknstyle/data/models/delivery_info/address_model.dart'; // Adjust the import path as necessary
abstract class AddressRemoteDataSource {
  Future<void> saveAddress(AddressModel address);
}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final http.Client client;

  AddressRemoteDataSourceImpl({required this.client});

  @override
  Future<void> saveAddress(AddressModel address) async {
    final response = await client.post(
      Uri.parse('https://'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(address.toJson()),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }
}