// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/controller/todocontroller.dart';
import 'package:todo_app/model/todomodel.dart';
import 'package:todo_app/utils/api_constants.dart';

class TodoServices {
  TodoController todoController = Get.put(TodoController());

  gettodo({
    required userId,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/getusertodo'),
        body: jsonEncode({
          "userId": userId,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      await todoController.setvalue(todomodelFromJson(res.body));
    } catch (e) {
      print("error");
      print(e);
    }
  }

  storetodo({
    required userId,
    required task,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/storetodo'),
        body:
            jsonEncode({"userId": userId, "task": task, "isCompleted": false}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      Map<String, dynamic> responsedata = jsonDecode(res.body);
      Todomodel todo = Todomodel(
        id: Todomodel.fromJson(responsedata).id,
        userId: userId,
        task: Todomodel.fromJson(responsedata).task,
        isCompleted: Todomodel.fromJson(responsedata).isCompleted,
        v: Todomodel.fromJson(responsedata).v,
      );
      todoController.addvalue(todo);
    } catch (e) {
      print(e);
    }
  }

  updatetodostatus({
    required id,
    required isCompleted,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/updateStatus'),
        body: jsonEncode({
          "id": id,
          "isCompleted": isCompleted,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      log(res.body);
    } catch (e) {
      print(e);
    }
  }

  deletetodo({required id}) async {
    try {
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/deletetodo'),
        body: jsonEncode({"id": id}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      log(res.body);
    } catch (e) {
      log(e.toString());
    }
  }
}
