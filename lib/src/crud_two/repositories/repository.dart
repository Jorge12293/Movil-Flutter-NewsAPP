// Models Dart
//https://javiercbk.github.io/json_to_dart/

//https://jsonplaceholder.typicode.com/

import 'package:appcrudflutter/src/crud_two/models/todo.dart';

abstract class Repository{
  //get
  Future<List<Todo>> getTodoList();
  //patch
  Future<String> patchCompleted(Todo todo);
  //put
  Future<String> putCompleted(Todo todo);
  //delete
  Future<String> deleteTodo(Todo todo);
  //posts
  Future<String> postTodo(Todo todo);

}