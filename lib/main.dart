// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/controller/logincontroller.dart';
import 'package:todo_app/controller/signupcontroller.dart';
import 'package:todo_app/controller/todocontroller.dart';
import 'package:todo_app/controller/usercontroller.dart';
import 'package:todo_app/theme/theme_helper.dart';
import 'package:todo_app/utils/sizeutils.dart';
import 'package:todo_app/view/home.dart';
import 'package:todo_app/view/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');
  runApp(MyApp(
    token: prefs.getString("x-auth-token"),
  ));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          theme: theme,
          title: 'to-do app',
          debugShowCheckedModeBanner: false,
          // home: const homescreen(),
          // home: login(),
          home: token != null
              ? JwtDecoder.isExpired(token!)
                  ? login()
                  : homescreen(token!)
              : login(),
          initialBinding: BindingsBuilder(() {
            Get.put(UserController());
            // Get.lazyPut<TodoController>(() => TodoController());
            Get.put(TodoController());
            Get.put(logincontroller());
            Get.put(signupcontroller());
          }),
        );
      },
    );
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   runApp(
//     GetMaterialApp(
//       home: JwtDecoder.isExpired('${pref.getString("x-auth-token")}')
//           ? login()
//           : homescreen(),
//       initialBinding: BindingsBuilder(() {
//         Get.put(UserController());
//         Get.put(TodoController());
//         Get.put(signupcontroller());
//         Get.put(logincontroller());
//       }),
//     ),
//   );
// }
