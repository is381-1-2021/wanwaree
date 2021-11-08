import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final int userId;
  final int id;
  final String title;
  bool completed;

  Todo(this.userId, this.id, this.title, this.completed);

  factory Todo.fromJson(
    Map<String, dynamic> json,
  ) {
    return Todo(
      json['userId'] as int,
      json['id'] as int,
      json['title'] as String,
      json['completed'] as bool,
    );
  }
}

class AllTodos {
  final List<Todo> todos;

  AllTodos(this.todos);

  factory AllTodos.fromJson(
    List<dynamic> json,
  ) {
    var x = json.map((record) => Todo.fromJson(record)).toList();

    return AllTodos(x);
  }

  factory AllTodos.formSnapshot(QuerySnapshot snapshot) {
    var x = snapshot.docs.map((record) {
      return Todo.fromJson(record.data() as Map<String, dynamic>);
    }).toList();

    return AllTodos(x);
  }
}
