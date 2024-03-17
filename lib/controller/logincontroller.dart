// ignore_for_file: camel_case_types

import 'package:get/get.dart';

class logincontroller extends GetxController {
  RxString emailerror = "".obs;
  RxString nameerror = "".obs;
  RxString passerror = "".obs;
  RxBool isLoading = false.obs;

  bool isloading(v) {
    isLoading.value = v;
    return isLoading.value;
  }

  emailcheck(value) {
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(value)) {
      // If the entered text is not a valid email format
      emailerror.value = "Enter a valid email";
    } else {
      // If the entered text is a valid email format
      emailerror.value = "Valid email";
    }
  }

  passcheck(value) {
    if (value.toString().length >= 6) {
      passerror.value = "";
    } else {
      passerror.value = "Enter a valid password";
    }
  }

  bool isvalid(value) {
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(value)) {
      // If the entered text is not a valid email format
      emailerror.value = "Enter a valid email";
      return false;
    } else {
      // If the entered text is a valid email format
      emailerror.value = "Valid email";
      return true;
    }
  }

  bool passvalid(value) {
    if (value.length >= 6) {
      return true;
    } else {
      passerror.value = "Enter the password";
      return false;
    }
  }

  void clearerror() {
    emailerror.value = "";
    nameerror.value = '';
  }
}
