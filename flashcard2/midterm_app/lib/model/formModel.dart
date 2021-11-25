import 'package:flutter/material.dart';

class FormModel extends ChangeNotifier {
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _password;
  bool _islogin = false;
  String? _cardID;

  List<String> questions = <String>[];
  List<String> answers = <String>[];

  List<String> cardNameList = <String>[];
  List<String> subjectList = <String>[];

// sign up Aand Log in --------------------------------

  get email => this._email;

  set email(value) {
    this._email = value;
    notifyListeners();
  }

  get firstName => this._firstName;

  set firstName(value) {
    this._firstName = value;
    notifyListeners();
  }

  get lastName => this._lastName;

  set lastName(value) {
    this._lastName = value;
    notifyListeners();
  }

  get password => this._password;

  set password(value) {
    this._password = value;
    notifyListeners();
  }

  bool get islogin => this._islogin;

  set islogin(bool value) {
    this._islogin = value;
    notifyListeners();
  }

  get cardID => this._cardID;

  set CardID(value) {
    this._cardID = value;
    notifyListeners();
  }

// Question and Answer in Flash Card ------------------

  get Questions => this.questions;

  set Questions(value) {
    this.questions = value;
    notifyListeners();
  }

  get Answers => this.answers;

  set Answers(value) {
    this.answers = value;
    notifyListeners();
  }

// Flash Card ----------------------------------------

  get cardName => this.cardNameList;

  set cardName(value) {
    this.cardNameList = value;
    notifyListeners();
  }

  get subject => this.subjectList;

  set subject(value) {
    this.subjectList = value;
    notifyListeners();
  }
}
