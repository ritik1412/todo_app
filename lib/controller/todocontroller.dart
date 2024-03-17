import 'dart:developer';

import 'package:get/get.dart';
import 'package:todo_app/model/todomodel.dart';

class TodoController extends GetxController {
  var todoList = <Todomodel>[].obs;
  // TodoServices todoServices = TodoServices();
  // @override
  // void initState() {
  //   todoServices.gettodo(userId: UserData.id);
  // }

  setvalue(List<Todomodel> tododata) async{
     todoList.value = tododata;
  }

  addvalue(Todomodel todo) {
    todoList.add(todo);
  }

  updatedTodoStatus(String id, bool status) {
    //  Todomodel todo = todoList.firstWhere((e) => e.id == id);
    //  todo.isCompleted = status;
    log("status");
    todoList.firstWhere((element) => element.id == id).isCompleted = status;
  }

  bool getTodoStatus(String id) {
    return todoList.firstWhere((element) => element.id == id).isCompleted;
  }

  deleteTodo(String id) {
    todoList.removeWhere((element) => element.id == id);
  }
}
