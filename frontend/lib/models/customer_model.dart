import 'adress_model.dart';

class CustomerModel {
  final String id;
  final String name;
  final String email;
  final AdressModel adress;
  final String? phone;

  CustomerModel(
    this.id, {
    required this.name,
    required this.email,
    required this.adress,
    this.phone,
  });
}
