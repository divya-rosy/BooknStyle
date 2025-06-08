import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booknstyle/domain/usecases/delivery_info/save_address.dart';
import 'address_event.dart';
import 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final SaveAddress saveAddress;

  AddressBloc({required this.saveAddress}) : super(AddressInitial()) {
    on<SaveAddressEvent>((event, emit) async {
      emit(AddressSaving());
      final result = await saveAddress(event.address);
      emit(result.fold(
        (failure) => AddressError(failure.toString()),
        (_) => AddressSaved(),
      ));
    });
  }
}