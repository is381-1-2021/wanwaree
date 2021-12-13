import 'dart:async';

import 'package:midterm_app/pages/history_model.dart';
import 'package:midterm_app/services/services.dart';

class HistoryController {
  final Services services;
  List<History> historys = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  HistoryController(this.services);

  Future<List<History>> fetchHistorys() async {
    onSyncController.add(true);
    historys = await services.getHistorys();
    onSyncController.add(false);

    return historys;
  }
}
