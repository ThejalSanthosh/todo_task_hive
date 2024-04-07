import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_task/model/todo_model.dart';

class TodoController {
  static List todoListKeys = [];

  static var box = Hive.box<TodoModel>("todo");

  static getInitKeys() {
    todoListKeys = box.keys.toList();
  }

  static addTodoData(TodoModel todoModel) async {
    await box.add(todoModel);
    getInitKeys();
  }

  static TodoModel? getTodoData(var key) {
    return box.get(key);
  }

  static deleteTodoData(var key) async {
    await box.delete(key);
    getInitKeys();
  }

  static updateTodoCompleted(var key, TodoModel todoModel) async {
    await box.put(key, todoModel);
    getInitKeys();
    print(todoModel.isCompleted);
  }
}
