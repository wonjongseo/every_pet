import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/models/todo_model.dart';
import 'package:every_pet/respository/todo/i_todo_repository.dart';
import 'package:hive/hive.dart';

class TodoRepository extends ITodoRepository {
  @override
  Future<void> saveTodo(TodoModel todo) async {
    var box = await Hive.openBox<TodoModel>(AppConstant.todoModelBox);

    await box.put(_todoKey(todo), todo);

    print('Todos saved!');
  }

  @override
  Future<void> updateTodo(TodoModel oldTodo, TodoModel newTodo) async {
    await deleteTodo(oldTodo);
    await saveTodo(newTodo);
  }

  @override
  Future<void> deleteTodo(TodoModel todo) async {
    var box = await Hive.openBox<TodoModel>(AppConstant.todoModelBox);

    await box.delete(_todoKey(todo));
    await box.delete(_legacyTodoKey(todo));

    print('Todos deleted!');
  }

  @override
  Future<List<TodoModel>> getTodos() async {
    var box = await Hive.openBox<TodoModel>(AppConstant.todoModelBox);

    List<TodoModel> todos = box.values
        // .where((element) => element.petModel!.name == petName)
        .toList();

    return todos;
  }

  String _todoKey(TodoModel todo) {
    final petId = todo.petModel?.id ?? '';
    return '${todo.dateTime.year}-${todo.dateTime.month}-${todo.dateTime.day}-$petId';
  }

  String _legacyTodoKey(TodoModel todo) {
    final petName = todo.petModel?.name ?? '';
    return '${todo.dateTime.year}-${todo.dateTime.month}-${todo.dateTime.day}-$petName}';
  }
}
