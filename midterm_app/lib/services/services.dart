import 'package:midterm_app/pages/history_model.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Services {
  Future<List<History>> getHistorys();
}

class FirebaseServices extends Services {
  @override
  Future<List<History>> getHistorys() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('waree_memory').get();

    var all = AllHistorys.formSnapshot(snapshot);

    return all.historys;
  }
}
