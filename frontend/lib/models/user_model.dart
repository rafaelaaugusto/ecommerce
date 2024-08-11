import 'package:uuid/uuid.dart';

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

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      const Uuid().v4(),
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      adress: AdressModel.fromJson(
        data['adress'],
      ),
    );
  }
}
