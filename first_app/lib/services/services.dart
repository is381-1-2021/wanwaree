import 'package:first_app/pages/todo_model.dart';
import 'package:http/http.dart';
import 'dart:convert';

class HttpServices {
  Client client = Client();

  Future<List<Todo>> getTodos() async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/todos'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load todos');
    }

    var all = AllTodos.fromJson(json.decode(response.body));

    return all.todos;
  }
}
