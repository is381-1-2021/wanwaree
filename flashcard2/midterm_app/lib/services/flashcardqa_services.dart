import 'package:midterm_app/pages/flashcardqa_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:midterm_app/pages/listfc_model.dart';
import 'package:midterm_app/pages/stackofcard_model.dart';

abstract class Services {
  Future<List<Flashcardqa>> getFlashcardqas();
  Future<List<Listfc>> getListfcs();
  Future<List<Stackofcard>> getStackofcards();
}

class FirebaseServices extends Services {
  @override
  Future<List<Flashcardqa>> getFlashcardqas() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('fc_flashcardqa').get();

    var all = AllFlashcardqas.formSnapshot(snapshot);

    return all.flashcardqas;
  }

  Future<List<Listfc>> getListfcs() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('fc_flashcardqa').get();

    var all = AllListfcs.formSnapshot(snapshot);

    return all.listfcs;
  }

  Future<List<Stackofcard>> getStackofcards() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('fc_cards').get();

    var all = AllStackofcards.formSnapshot(snapshot);

    return all.stackofcards;
  }
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
