import 'package:flutter/material.dart';

class FormModel extends ChangeNotifier {
  String? _Username;
  String? _email;
  get Username => this._Username;

  set Username(value) {
    this._Username = value;
    notifyListeners();
  }

  get email {
    this._email;
    notifyListeners();
  }

  set email(value) {
    this._email = value;
    notifyListeners();
  }
}
