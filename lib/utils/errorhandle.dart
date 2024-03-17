import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      // print(jsonDecode(response.body)['msg']);
      Get.snackbar("Error", jsonDecode(response.body)['msg'],
          backgroundColor: Colors.white,
          duration: const Duration(milliseconds: 1000)); //msg
      break;
    case 500:
      Get.snackbar("", jsonDecode(response.body),
          backgroundColor: Colors.white,
          duration: const Duration(milliseconds: 1000)); //error
      break;
    default:
      Get.snackbar("Error", jsonDecode(response.body)['msg'],
          backgroundColor: Colors.white,
          duration: const Duration(milliseconds: 1000));
      // print(jsonDecode(response.body.toString()));
  }
}
