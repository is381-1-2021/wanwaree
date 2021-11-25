import 'package:cloud_firestore/cloud_firestore.dart';

//Test_model.dart
class Testsubcoll {
  final String name;
  final String subject;

  Testsubcoll(this.name, this.subject);

  factory Testsubcoll.fromJson(
    Map<String, dynamic> json,
  ) {
    return Testsubcoll(
      json['name'] as String,
      json['subject'] as String,
    );
  }
}

class AllTestsubcolls {
  final List<Testsubcoll> testsubcolls;

  AllTestsubcolls(this.testsubcolls);

  factory AllTestsubcolls.fromJson(
    List<dynamic> json,
  ) {
    var x = json.map((record) => Testsubcoll.fromJson(record)).toList();

    return AllTestsubcolls(x);
  }

  factory AllTestsubcolls.formSnapshot(QuerySnapshot snapshot) {
    var x = snapshot.docs.map((record) {
      return Testsubcoll.fromJson(record.data() as Map<String, dynamic>);
    }).toList();

    return AllTestsubcolls(x);
  }
}
