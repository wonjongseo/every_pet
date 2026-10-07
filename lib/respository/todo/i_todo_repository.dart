import 'package:every_pet/models/todo_model.dart';

abstract class ITodoRepository {
  Future<void> saveTodo(TodoModel todo);

  Future<void> updateTodo(TodoModel oldTodo, TodoModel newTodo);

  Future<void> deleteTodo(TodoModel todo);

  Future<List<TodoModel>> getTodos();
}
