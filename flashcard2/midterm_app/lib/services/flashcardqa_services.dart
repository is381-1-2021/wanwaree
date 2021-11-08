import 'package:midterm_app/pages/flashcardqa_model.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Services {
  Future<List<Flashcardqa>> getFlashcardqas();
}

class FirebaseServices extends Services {
  @override
  Future<List<Flashcardqa>> getFlashcardqas() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('fc_flashcardqa').get();

    var all = AllFlashcardqas.formSnapshot(snapshot);

    return all.flashcardqas;
  }
}

class HttpServices extends Services {
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
}
