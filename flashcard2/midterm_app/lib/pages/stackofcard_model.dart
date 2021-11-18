import 'package:cloud_firestore/cloud_firestore.dart';

class Stackofcard {
  final String name;
  final String subject;

  Stackofcard(this.name, this.subject);

  factory Stackofcard.fromJson(
    Map<String, dynamic> json,
  ) {
    return Stackofcard(
      json['name'] as String,
      json['subject'] as String,
    );
  }
}

class AllStackofcards {
  final List<Stackofcard> stackofcards;

  AllStackofcards(this.stackofcards);

  factory AllStackofcards.fromJson(
    List<dynamic> json,
  ) {
    var x = json.map((record) => Stackofcard.fromJson(record)).toList();

    return AllStackofcards(x);
  }

  factory AllStackofcards.formSnapshot(QuerySnapshot snapshot) {
    var x = snapshot.docs.map((record) {
      return Stackofcard.fromJson(record.data() as Map<String, dynamic>);
    }).toList();

    return AllStackofcards(x);
  }
}
