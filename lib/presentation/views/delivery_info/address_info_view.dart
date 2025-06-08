// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booknstyle/domain/entities/delivery_info/address.dart';
import 'package:booknstyle/presentation/blocs/delivery_info/address_bloc.dart';
import 'package:booknstyle/presentation/blocs/delivery_info/address_event.dart';
import 'package:booknstyle/presentation/blocs/delivery_info/address_state.dart';
import 'package:booknstyle/domain/usecases/delivery_info/save_address.dart';

class AddressFormPage extends StatefulWidget {
  const AddressFormPage({super.key});

  @override
  _AddressFormPageState createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _countryController = TextEditingController();
  final bool _isBilling = false;

  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Address Form')),
      body: BlocProvider(
        create: (context) => AddressBloc(
          saveAddress: context.read<SaveAddress>(),
        ),
        child: BlocListener<AddressBloc, AddressState>(
          listener: (context, state) {
            if (state is AddressSaved) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Address saved successfully')),
              );
              Navigator.pop(context);
            } else if (state is AddressError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _streetController,
                    decoration: const InputDecoration(labelText: 'Street'),
                    validator: (value) => value!.isEmpty ? 'Enter street' : null,
                  ),
                  DropdownButtonFormField<String>(
                    value: null,
                    decoration: const InputDecoration(labelText: 'City'),
                    items: ['City 1', 'City 2', 'City 3']
                        .map((city) => DropdownMenuItem(
                              value: city,
                              child: Text(city),
                            ))
                        .toList(),
                    onChanged: (value) {
                      _cityController.text = value!;
                    },
                    validator: (value) =>
                        value == null ? 'Select a city' : null,
                  ),
                  DropdownButtonFormField<String>(
                    value: null,
                    decoration: const InputDecoration(labelText: 'State'),
                    items: ['State 1', 'State 2', 'State 3']
                        .map((state) => DropdownMenuItem(
                              value: state,
                              child: Text(state),
                            ))
                        .toList(),
                    onChanged: (value) {
                      _stateController.text = value!;
                    },
                    validator: (value) =>
                        value == null ? 'Select a state' : null,
                  ),
                  DropdownButtonFormField<String>(
                    value: null,
                    decoration: const InputDecoration(labelText: 'Postal Code'),
                    items: ['12345', '67890', '54321']
                        .map((postalCode) => DropdownMenuItem(
                              value: postalCode,
                              child: Text(postalCode),
                            ))
                        .toList(),
                    onChanged: (value) {
                      _postalCodeController.text = value!;
                    },
                    validator: (value) =>
                        value == null ? 'Select a postal code' : null,
                  ),
                  DropdownButtonFormField<String>(
                    value: null,
                    decoration: const InputDecoration(labelText: 'Country'),
                    items: ['Country 1', 'Country 2', 'Country 3']
                        .map((country) => DropdownMenuItem(
                              value: country,
                              child: Text(country),
                            ))
                        .toList(),
                    onChanged: (value) {
                      _countryController.text = value!;
                    },
                    validator: (value) =>
                        value == null ? 'Select a country' : null,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AddressBloc>().add(
                              SaveAddressEvent(
                                Address(
                                  userId: 'user123', // Replace with actual user ID
                                  addressId: 'address123', // Replace with actual address ID
                                  street: _streetController.text,
                                  city: _cityController.text,
                                  state: _stateController.text,
                                  postalCode: _postalCodeController.text,
                                  country: _countryController.text,
                                  isBilling: _isBilling,
                                ),
                              ),
                            );
                      }
                    },
                    child: const Text('Save Address'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}