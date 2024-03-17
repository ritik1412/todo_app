// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_constructors_in_immutables, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/controller/logincontroller.dart';
import 'package:todo_app/services/auth_services.dart';
import 'package:todo_app/view/signup.dart';
import 'package:todo_app/theme/app_decoration.dart';
import 'package:todo_app/theme/theme_helper.dart';
import 'package:todo_app/utils/image_constant.dart';
import 'package:todo_app/utils/sizeutils.dart';
import 'package:todo_app/widget/custom_elevated_button.dart';
import 'package:todo_app/widget/custom_image_view.dart';

class login extends StatefulWidget {
  login({Key? key})
      : super(
          key: key,
        );

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final logincontroller authlogincontroller = Get.put(logincontroller());

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final AuthService authService = AuthService();
  void signin() {
    authService.signin(
      email: emailController.text,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: SizeUtils.height,
            width: double.maxFinite,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _buildImageStack(context),
                _buildLoginForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildImageStack(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 315.v,
        width: double.maxFinite,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgSl02101214057020,
              height: 315.v,
              width: 360.h,
              alignment: Alignment.center,
            ),
            CustomImageView(
              imagePath: ImageConstant.imgRectangle2,
              height: 86.v,
              width: 90.h,
              radius: BorderRadius.only(
                topLeft: Radius.circular(10.h),
                bottomLeft: Radius.circular(10.h),
                bottomRight: Radius.circular(10.h),
              ),
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 66.v),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildLoginForm(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 3.v),
        padding: EdgeInsets.symmetric(
          horizontal: 32.h,
          vertical: 59.v,
        ),
        decoration: AppDecoration.fillGray.copyWith(
          borderRadius: BorderRadiusStyle.customBorderTL94,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Login",
              style: theme.textTheme.displayMedium,
            ),
            SizedBox(height: 55.v),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    12.h,
                  ),
                  bottomLeft: Radius.circular(
                    12.h,
                  ),
                  bottomRight: Radius.circular(
                    12.h,
                  ),
                ),
              ),
              height: 80.v,
              child: Center(
                child: TextField(
                  style: TextStyle(fontSize: 24, color: Colors.black),
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      // errorText: passerror,
                      // labelText: "Email",
                      hintText: "Enter your email",
                      hintStyle: TextStyle(fontSize: 24, color: Colors.black)),
                  onChanged: (value) {
                    authlogincontroller.emailcheck(value);
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(6, 2, 0, 0),
                child: Obx(
                  () => Text(
                    authlogincontroller.emailerror.value,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: authlogincontroller.emailerror.value.length > 11
                            ? Colors.red
                            : Colors.green),
                  ),
                ),
              ),
            ),

            // CustomTextFormField(
            //   controller: emailController,
            //   hintText: "Enter email",
            //   textInputType: TextInputType.emailAddress,
            // ),
            SizedBox(height: 34.v),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    12.h,
                  ),
                  bottomLeft: Radius.circular(
                    12.h,
                  ),
                  bottomRight: Radius.circular(
                    12.h,
                  ),
                ),
              ),
              height: 80.v,
              child: Center(
                child: TextField(
                  style: TextStyle(fontSize: 24, color: Colors.black),
                  controller: passwordController,
                  obscureText: true,
                  onChanged: (value) {
                    authlogincontroller.passcheck(value);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Enter your password",
                      hintStyle: TextStyle(fontSize: 24, color: Colors.black)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(6, 2, 0, 0),
                child: Obx(
                  () => Text(
                    authlogincontroller.passerror.value,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: passwordController.text.length < 6
                            ? Colors.red
                            : Colors.transparent),
                  ),
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomLeft,
            //   child: Padding(
            //     padding: EdgeInsets.fromLTRB(6, 2, 0, 0),
            //     child: Text(
            //       passerror,
            //       textAlign: TextAlign.left,
            //       style: TextStyle(
            //           color: passerror.length > 5 ? Colors.red : Colors.green),
            //     ),
            //   ),
            // ),
            // CustomTextFormField(
            //   controller: passwordController,
            //   hintText: "Enter password",
            //   // textInputAction: TextInputAction.done,
            //   textInputType: TextInputType.visiblePassword,
            //   obscureText: true,

            // ),
            SizedBox(height: 50.v),
            Obx(() => authlogincontroller.isLoading.value
                ? SizedBox(
                    height: 63.v,
                    child: Lottie.asset('assets/lottie/login_waiting.json',
                        repeat: true, fit: BoxFit.contain))
                : CustomElevatedButton(
                    onPressed: () {
                      if (authlogincontroller.isvalid(emailController.text) &
                          authlogincontroller
                              .passvalid(passwordController.text)) {
                        signin();
                      }
                    },
                    text: "Login",
                  )),
            SizedBox(height: 24.v),
            TextButton(
              onPressed: () {
                authlogincontroller.clearerror();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return signup();
                }));
              },
              child: Text(
                "Don't have an account? Sign Up now",
                style: theme.textTheme.displaySmall,
              ),
            )
          ],
        ),
      ),
    );
  }
}
