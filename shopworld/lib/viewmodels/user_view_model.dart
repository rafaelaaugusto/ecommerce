import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/user_model.dart';

final userProvider = ChangeNotifierProvider<UserProvider>(
  (ref) => UserProvider(),
);

class UserProvider extends ChangeNotifier {
  UserModel? user;

  String get getId => const Uuid().v4();
  UserModel? get currentUser => user;

  void setUser(UserModel newUser) {
    user = newUser;
    notifyListeners();
  }
}
