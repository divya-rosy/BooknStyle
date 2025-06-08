import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String userId; // Added userId for consistency with other entities
  final String addressId; // Unique identifier for the address
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final bool isBilling;

  const Address({
    required this.userId,
    required this.addressId,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.isBilling,
  });

  @override
  List<Object> get props => [userId, addressId, street, city, state, postalCode, country, isBilling];
}