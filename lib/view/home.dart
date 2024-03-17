// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:todo_app/controller/todocontroller.dart';
import 'package:todo_app/services/todo_services.dart';
import 'package:todo_app/theme/app_decoration.dart';
import 'package:todo_app/theme/theme_helper.dart';
import 'package:todo_app/utils/sizeutils.dart';

// void main() {
//   runApp(MaterialApp(
//     home: homescreen(),
//     debugShowCheckedModeBanner: false,
//   ));
// }

class homescreen extends StatefulWidget {
  final String token;
  const homescreen(this.token, {super.key});
  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen>
    with SingleTickerProviderStateMixin {
  // UserController userController = Get.put(UserController());
  TodoController todoController = Get.find();
  TodoServices todoServices = TodoServices();
  @override
  void initState() {
    super.initState();
    todoServices.gettodo(userId: JwtDecoder.decode(widget.token)['id']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray50,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                image_icon(context, 'assets/images/img_search.svg'),
                image_icon(context, 'assets/images/img_vector.svg'),
                SizedBox(
                  width: 30.h,
                ),
              ]),
              SizedBox(
                width: 30.h,
              ),
              SizedBox(height: 29.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 32.h),
                  child: Text(
                    "What’s up, ${JwtDecoder.decode(widget.token)['name']}",
                    style: TextStyle(
                      color: appTheme.black900,
                      fontSize: 32.fSize,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 23.v),
              _buildUserProfile(context),
              SizedBox(height: 26.v),
              _buildTaskList(context),
              SizedBox(
                height: 25.h,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 65, 65, 67),
        onPressed: () {
          TextEditingController taskcontroller = TextEditingController();
          Get.defaultDialog(
              title: "Add a To-Do",
              content: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: taskcontroller,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'To-Do',
                        hintMaxLines: 1,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: appTheme.purpleA400, width: 10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 77, 75, 75)),
                      ),
                      onPressed: () {
                        if (taskcontroller.text.isNotEmpty &&
                            JwtDecoder.decode(widget.token)['name'] != null) {
                          // print(JwtDecoder.decode(widget.token)['id']
                          //     .runtimeType);
                          todoServices.storetodo(
                            userId: JwtDecoder.decode(widget.token)['id'],
                            task: taskcontroller.text.toString(),
                          );
                          // print(taskcontroller.text.toString());
                          Get.back();
                        } else {
                          Get.snackbar(
                              "Are you sure?", "To-Do can't be empty..",
                              backgroundColor: Colors.white);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
                        child: Text(
                          "Add",
                          style: TextStyle(color: appTheme.whiteA700),
                        ),
                      ))
                ],
              ));
          // todoServices.storetodo(userId: "121413131", task: "my task");
        },
        child: Icon(
          Icons.add,
          color: appTheme.whiteA700,
        ),
      ),
    );
  }

  Widget image_icon(BuildContext context, String path) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(
          left: 25.h,
          top: 15.v,
          // right: 15.h,
        ),
        child: SvgPicture.asset(path),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total tasks",
            style: TextStyle(
              color: appTheme.blueGray300,
              fontSize: 16.fSize,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 23.v),
          Container(
            width: 208.h,
            margin: EdgeInsets.only(right: 87.h),
            padding: EdgeInsets.symmetric(
              horizontal: 11.h,
              vertical: 18.v,
            ),
            decoration: AppDecoration.outlineBlack.copyWith(
              borderRadius: BorderRadiusStyle.customBorderTL12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    "${todoController.todoList.length} Tasks",
                    style: TextStyle(
                      color: appTheme.blueGray300,
                      fontSize: 16.fSize,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 31.v),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 3.v,
                    width: 175.h,
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: 175.h,
                            child: Divider(
                              thickness: 5.v,
                            ),
                          ),
                        ),
                        Obx(
                          () => Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: 175 *
                                  todoController.todoList.length /
                                  (10 + todoController.todoList.length),
                              child: Divider(
                                thickness: 5.v,
                                color: appTheme.purpleA400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.v),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 31.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: Text(
              "Tasks",
              style: TextStyle(
                color: appTheme.blueGray300,
                fontSize: 16.fSize,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 23.v),
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Obx(
              () => todoController.todoList.isEmpty
                  ? Center(
                      child: Text(
                        "NO TASKS",
                        style: TextStyle(
                          color: appTheme.blueGray300,
                          fontSize: 16.fSize,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : ListView.builder(
                      reverse: true,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: todoController.todoList.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 300),
                          child: SlideAnimation(
                            curve: Curves.easeInOut,
                            verticalOffset: -20.0,
                            child: FadeInAnimation(
                              curve: Curves.easeInOut,
                              child: todocard(context, index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget todocard(BuildContext context, int index) {
    String id = todoController.todoList[index].id;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        margin: const EdgeInsets.all(0),
        color: appTheme.whiteA700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyle.customBorderTL12,
        ),
        child: Container(
          height: 59.v,
          width: 296.h,
          decoration: AppDecoration.outlineBlack90001.copyWith(
            borderRadius: BorderRadiusStyle.customBorderTL12,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.h,
                vertical: 19.v,
              ),
              decoration: AppDecoration.outlineBlack90001.copyWith(
                borderRadius: BorderRadiusStyle.customBorderTL12,
              ),
              child: Row(
                children: [
                  Container(
                    height: 20.adaptSize,
                    width: 20.adaptSize,
                    margin: EdgeInsets.only(bottom: 1.v),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10.h,
                      ),
                      border: Border.all(
                        color: index % 2 == 0
                            ? appTheme.blueA700
                            : appTheme.purpleA400,
                        width: 1.h,
                        strokeAlign: strokeAlignCenter,
                      ),
                    ),
                    child: GetBuilder<TodoController>(
                      builder: (_) => Checkbox(
                        side: const BorderSide(color: Colors.transparent),
                        activeColor: appTheme.blueGray300,
                        value: todoController.getTodoStatus(id),
                        shape: const CircleBorder(),
                        onChanged: (bool? value) {
                          todoServices.updatetodostatus(
                              id: id, isCompleted: value);
                          todoController.updatedTodoStatus(id, value!);
                          todoController.update();
                          log(todoController.todoList[index].isCompleted
                              .toString());
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18.h),
                    child: GetBuilder<TodoController>(
                      builder: (_) => Text(
                        todoController.todoList[index].task,
                        style: TextStyle(
                            color: appTheme.black90001,
                            fontSize: 15.fSize,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            decoration: todoController.getTodoStatus(id)
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GetBuilder<TodoController>(
                    builder: (_) => InkWell(
                      onTap: () {
                        todoServices.deletetodo(id: id);
                        todoController.deleteTodo(id);
                      },
                      child: Icon(
                        Icons.delete,
                        color: appTheme.blueGray500,
                      ),
                    ),
                  )
                  // IconButton(
                  //     color: appTheme.blueGray500,
                  //     onPressed: () {
                  //       todoServices.deletetodo(id: id);
                  //     },
                  //     icon: const Icon(Icons.delete))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
