
import 'package:appcrudflutter/src/crud_two/models/todo.dart';
import 'package:appcrudflutter/src/crud_two/repositories/repository.dart';

class TodoController {
  final Repository _repository;

  TodoController(this._repository);

  Future<List<Todo>> fetchTodoList() async{
    return _repository.getTodoList();
  }

  Future<String> updatePatchCompted(Todo todo) async{
    return _repository.patchCompleted(todo);
  }

  Future<String> updatePutCompleted(Todo todo) async{
    return _repository.putCompleted(todo);
  }

  Future<String> deleteTodoCompleted(Todo todo) async{
    return _repository.deleteTodo(todo);
  }

    Future<String> postTodoCompleted(Todo todo) async{
    return _repository.postTodo(todo);
  }

}