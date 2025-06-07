import 'package:equatable/equatable.dart';
import 'package:booknstyle/domain/entities/delivery_info/address.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class SaveAddressEvent extends AddressEvent {
  final Address address;

  const SaveAddressEvent(this.address);

  @override
  List<Object> get props => [address];
}