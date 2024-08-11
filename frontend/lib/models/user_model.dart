import 'adress_model.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final AdressModel adress;
  final String? phone;

  UserModel(
    this.id, {
    required this.name,
    required this.email,
    required this.adress,
    this.phone,
  });
}
