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

  factory UserModel.fromJson(String id, Map<String, dynamic> data) {
    return UserModel(
      id,
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      adress: AdressModel.fromJson(data['adress']),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'adress': adress.toMap(),
    };
  }
}
