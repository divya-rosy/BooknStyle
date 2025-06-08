import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import 'package:booknstyle/domain/entities/delivery_info/address.dart';
import '../../domain/repositories/address_repository.dart';
import 'package:booknstyle/data/models/delivery_info/address_model.dart'; // Adjust the import path as necessary

class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource remoteDataSource;

  AddressRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> saveAddress(Address address) async {
    try {
      await remoteDataSource.saveAddress(AddressModel(
        userId: address.userId, 
        addressId: address.addressId,// Ensure userId is passed correctly
        street: address.street,
        city: address.city,
        state: address.state,
        postalCode: address.postalCode,
        country: address.country,
        isBilling: address.isBilling,
      ));
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}