import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/models/todo_model.dart';
import 'package:hive/hive.dart';

class TodoRepository {
  void saveTodo(TodoModel todo) async {
    var box = await Hive.openBox<TodoModel>('todos');

    await box.put(
      '${todo.dateTime.year}-${todo.dateTime.month}-${todo.dateTime.day}-${todo.petModel!.name}}',
      todo,
    );

    print('Todos saved!');
  }

  void updateTodo(TodoModel todo) async {
    await deleteTodo(todo);
    saveTodo(todo);
  }

  Future<void> deleteTodo(TodoModel todo) async {
    var box = await Hive.openBox<TodoModel>('todos');

    // 데이터 저장
    await box.delete(
        '${todo.dateTime.year}-${todo.dateTime.month}-${todo.dateTime.day}-${todo.petModel!.name}}');

    print('Todos deleted!');
  }

  Future<List<TodoModel>> getTodos() async {
    var box = await Hive.openBox<TodoModel>('todos');

    // 데이터 읽기
    print('todo.values : ${box.values.length}');

    List<TodoModel> todos = box.values
        // .where((element) => element.petModel!.name == petName)
        .toList();

    return todos;
  }
}
