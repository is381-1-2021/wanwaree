import 'dart:async';

import 'package:midterm_app/pages/listfc_model.dart';
import 'package:midterm_app/services/flashcardqa_services.dart';

class ListfcController {
  final Services services;
  List<Listfc> listfcs = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  ListfcController(this.services);

  Future<List<Listfc>> fetchListfcs() async {
    onSyncController.add(true);
    listfcs = await services.getListfcs();
    onSyncController.add(false);

    return listfcs;
  }
}
