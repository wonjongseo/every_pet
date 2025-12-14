import 'package:every_pet/models/todo_model.dart';

abstract class ITodoRepository {
  void saveTodo(TodoModel todo);

  void updateTodo(TodoModel todo);

  Future<void> deleteTodo(TodoModel todo);

  Future<List<TodoModel>> getTodos();
}
