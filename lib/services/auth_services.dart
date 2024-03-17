import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/logincontroller.dart';
import 'package:todo_app/controller/signupcontroller.dart';
import 'package:todo_app/services/todo_services.dart';
import 'package:todo_app/view/home.dart';
import 'package:todo_app/view/login.dart';
import 'package:todo_app/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/model/userdata.dart';
import 'package:todo_app/utils/api_constants.dart';
import 'package:todo_app/utils/errorhandle.dart';

class AuthService {
  logincontroller authloginconroller = Get.put(logincontroller());
  signupcontroller authsignupcontroller = Get.put(signupcontroller());
  TodoServices todoServices = TodoServices();

  void signUp({
    required String email,
    required String name,
    required String password,
  }) async {
    authsignupcontroller.isloading(true);
    try {
      // User user = User(
      //     id: '',
      //     name: name,
      //     email: email,
      //     token: '',
      //     password: password,
      //     v: 0);
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/register'),
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        onSuccess: () {
          Get.offAll(login());
          Get.snackbar(
            "Account Created!",
            "Please Login now",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white,
            duration: const Duration(seconds: 3),
          );
        },
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.white,
      );
    }
    authsignupcontroller.isloading(false);
  }

  void signin({
    required String email,
    required String password,
  }) async {
    authloginconroller.isloading(true);
    try {
      // final User user =
      //     User(id: '', name: '', email: email, token: '', password: password);
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        onSuccess: () async {
          if (res.statusCode == 200) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Map<String, dynamic> responsedata = jsonDecode(res.body);
            UserData.id = User.fromJson(responsedata).id;
            UserData.name = User.fromJson(responsedata).name;
            UserData.email = User.fromJson(responsedata).email;
            UserData.password = User.fromJson(responsedata).password;
            UserData.token = User.fromJson(responsedata).token;
            await prefs.setString('x-auth-token', UserData.token);
            todoServices.gettodo(userId: UserData.id);
            // print(UserData.token);
            Get.offAll(() => homescreen(UserData.token));
          } else {
            Get.snackbar(
              "Error",
              json.decode(res.body)['msg'].toString(),
              backgroundColor: Colors.white,
            );
          }
        },
      );
    } catch (e) {
      log(e.toString());
      // http.Response res = await http.post(
      //   Uri.parse('${Constants.uri}/signin'),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );
      // // print(res.statusCode);
      // Get.snackbar(
      //   "Error",
      //   json.decode(res.body)['msg'].toString(),
      //   backgroundColor: Colors.white,
      // );
    }
    authloginconroller.isloading(false);
  }
}
