import 'dart:async';

import 'package:midterm_app/pages/stackofcard_model.dart';
import 'package:midterm_app/services/flashcardqa_services.dart';

class StackofcardController {
  final Services services;
  List<Stackofcard> stackofcards = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  StackofcardController(this.services);

  Future<List<Stackofcard>> fetchStackofcards() async {
    onSyncController.add(true);
    stackofcards = await services.getStackofcards();
    onSyncController.add(false);

    return stackofcards;
  }
}
