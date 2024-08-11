import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';

final userProvider = ChangeNotifierProvider<UserProvider>(
  (ref) => UserProvider(),
);

class UserProvider extends ChangeNotifier {
  UserModel? user;

  UserModel? get currentUser => user;

  void setUser(UserModel newUser) {
    user = newUser;
    notifyListeners();
  }
}
