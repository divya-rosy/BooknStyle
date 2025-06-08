import 'package:equatable/equatable.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class AddressInitial extends AddressState {}

class AddressSaving extends AddressState {}

class AddressSaved extends AddressState {}

class AddressError extends AddressState {
  final String message;

  const AddressError(this.message);

  @override
  List<Object> get props => [message];
}