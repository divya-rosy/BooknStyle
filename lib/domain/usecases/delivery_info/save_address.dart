import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:booknstyle/domain/entities/delivery_info/address.dart';
import 'package:booknstyle/domain/repositories/address_repository.dart'; // Make sure this path is correct

class SaveAddress implements UseCase<void, Address> {
  final AddressRepository repository;

  SaveAddress(this.repository);

  @override
  Future<Either<Failure, void>> call(Address address) async {
    return await repository.saveAddress(address);
  }
}