import 'package:firebase_auth/firebase_auth.dart';
import 'package:midterm_app/pages/flashcardqa_model.dart';
import 'package:midterm_app/pages/stackofcard_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:midterm_app/pages/listfc_model.dart';
import 'package:midterm_app/pages/stackofcard_model.dart';

abstract class Services {
  Future<List<Flashcardqa>> getFlashcardqas();
  Future<List<Listfc>> getListfcs();
  Future<List<Stackofcard>> getStackofcards();
  //Future<List<Testsubcoll>> getTestsubcolls();
}

class FirebaseServices extends Services {
  @override
  Future<List<Flashcardqa>> getFlashcardqas() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('fc_subcards')
        .doc('Zzei3LvulpsixJC3Lh19')
        .collection('fc_flashcard')
        .get();

    var all = AllFlashcardqas.formSnapshot(snapshot);
    return all.flashcardqas;
  }

  Future<List<Listfc>> getListfcs() async {
    String? subid;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('fc_subcards')
        .doc('Zzei3LvulpsixJC3Lh19')
        .collection('fc_flashcard')
        .get();

    var all = AllListfcs.formSnapshot(snapshot);

    return all.listfcs;
  }

  Future<List<Stackofcard>> getStackofcards() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('fc_subcards').get();

    var all = AllStackofcards.formSnapshot(snapshot);

    return all.stackofcards;
  }

  /*Future<List<Testsubcoll>> getTestsubcolls() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('fc_history').get();

    var all = AllTestsubcolls.formSnapshot(snapshot);

    return all.testsubcolls;
  }*/
}

/*class HttpServices extends Services {
  Client client = Client();

  Future<List<Flashcardqa>> getFlashcardqas() async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/todos'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load todos');
    }

    var all = AllFlashcardqas.fromJson(json.decode(response.body));

    return all.flashcardqas;
  }
}*/
