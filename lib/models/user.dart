import 'package:todo/models/task.dart';
import 'package:todo/models/todo.dart';

class UserModel {
  String id;
  String name;
  String email;
  String? imgUrl;
  List<Todo>? todoList;
  List<Task>? taskList;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      this.imgUrl,
      this.todoList,
      this.taskList});

  toJson() {
    return {'id': id, 'name': name, 'email': email, 'imgUrl': imgUrl};
  }
}
