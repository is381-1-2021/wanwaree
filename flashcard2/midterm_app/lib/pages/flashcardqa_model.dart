import 'package:cloud_firestore/cloud_firestore.dart';

class Flashcardqa {
  final String question;
  final String answer;

  Flashcardqa(this.question, this.answer);

  factory Flashcardqa.fromJson(
    Map<String, dynamic> json,
  ) {
    return Flashcardqa(
      json['question'] as String,
      json['answer'] as String,
    );
  }
}

class AllFlashcardqas {
  final List<Flashcardqa> flashcardqas;

  AllFlashcardqas(this.flashcardqas);

  factory AllFlashcardqas.fromJson(
    List<dynamic> json,
  ) {
    var x = json.map((record) => Flashcardqa.fromJson(record)).toList();

    return AllFlashcardqas(x);
  }

  factory AllFlashcardqas.formSnapshot(QuerySnapshot snapshot) {
    var x = snapshot.docs.map((record) {
      return Flashcardqa.fromJson(record.data() as Map<String, dynamic>);
    }).toList();

    return AllFlashcardqas(x);
  }
}
