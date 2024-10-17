import 'package:flutter/material.dart';

final userNotifier = UserNotifier();

class UserNotifier extends ChangeNotifier {
  String? get email => _email;
  String? _email;

  set email(String? value) {
    if (_email != value) {
      _email = value;
      notifyListeners();
    }
  }

  bool get isSignedIn => _email != null;
}
