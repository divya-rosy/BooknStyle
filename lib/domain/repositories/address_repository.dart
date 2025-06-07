import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/delivery_info/address.dart';

abstract class AddressRepository {
  Future<Either<Failure, void>> saveAddress(Address address);
}