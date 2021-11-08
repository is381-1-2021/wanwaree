import 'dart:async';

import 'package:midterm_app/pages/todo_model.dart';
import 'package:midterm_app/services/services.dart';

class TodoController {
  final Services services;
  List<Todo> todos = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  TodoController(this.services);

  Future<List<Todo>> fetchTodos() async {
    onSyncController.add(true);
    todos = await services.getTodos();
    onSyncController.add(false);

    return todos;
  }
}
