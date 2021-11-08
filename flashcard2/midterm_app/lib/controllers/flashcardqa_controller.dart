import 'dart:async';

import 'package:midterm_app/pages/flashcardqa_model.dart';
import 'package:midterm_app/services/flashcardqa_services.dart';

class FlashcardqaController {
  final Services services;
  List<Flashcardqa> flashcardqas = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  FlashcardqaController(this.services);

  Future<List<Flashcardqa>> fetchFlashcardqas() async {
    onSyncController.add(true);
    flashcardqas = await services.getFlashcardqas();
    onSyncController.add(false);

    return flashcardqas;
  }
}
