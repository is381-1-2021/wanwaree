import 'package:flutter/foundation.dart';

class FormModel extends ChangeNotifier {
  //String? _process = '';
  //String? _result = '';
  List<String> process = <String>[];
  List<String> result = <String>[];

  get Process => this.process;

  set Process(value) {
    this.process = value;
    notifyListeners();
  }

  get Result => this.result;

  set Result(value) {
    this.result = value;
    notifyListeners();
  }
}
