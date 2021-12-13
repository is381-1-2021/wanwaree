import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  final String process;
  final String result;

  History(this.process, this.result);

  factory History.fromJson(
    Map<String, dynamic> json,
  ) {
    return History(
      json['process'] as String,
      json['result'] as String,
    );
  }
}

class AllHistorys {
  final List<History> historys;

  AllHistorys(this.historys);

  factory AllHistorys.fromJson(
    List<dynamic> json,
  ) {
    var x = json.map((record) => History.fromJson(record)).toList();

    return AllHistorys(x);
  }

  factory AllHistorys.formSnapshot(QuerySnapshot snapshot) {
    var x = snapshot.docs.map((record) {
      return History.fromJson(record.data() as Map<String, dynamic>);
    }).toList();

    return AllHistorys(x);
  }
}
