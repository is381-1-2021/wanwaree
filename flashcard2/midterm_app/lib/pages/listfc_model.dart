import 'package:cloud_firestore/cloud_firestore.dart';

class Listfc {
  final String question;
  final String answer;

  Listfc(this.question, this.answer);

  factory Listfc.fromJson(
    Map<String, dynamic> json,
  ) {
    return Listfc(
      json['question'] as String,
      json['answer'] as String,
    );
  }
}

class AllListfcs {
  final List<Listfc> listfcs;

  AllListfcs(this.listfcs);

  factory AllListfcs.fromJson(
    List<dynamic> json,
  ) {
    var x = json.map((record) => Listfc.fromJson(record)).toList();

    return AllListfcs(x);
  }

  factory AllListfcs.formSnapshot(QuerySnapshot snapshot) {
    var x = snapshot.docs.map((record) {
      return Listfc.fromJson(record.data() as Map<String, dynamic>);
    }).toList();

    return AllListfcs(x);
  }
}
