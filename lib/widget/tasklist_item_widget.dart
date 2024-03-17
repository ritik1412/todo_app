import 'package:flutter/material.dart';
import 'package:todo_app/theme/app_decoration.dart';
import 'package:todo_app/theme/theme_helper.dart';
import 'package:todo_app/utils/sizeutils.dart';

// ignore: must_be_immutable
class TasklistItemWidget extends StatefulWidget {
  const TasklistItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  State<TasklistItemWidget> createState() => _TasklistItemWidgetState();
}

class _TasklistItemWidgetState extends State<TasklistItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
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
                          color: appTheme.blueA700,
                          width: 1.h,
                          strokeAlign: strokeAlignCenter,
                        ),
                      ),
                      child: Checkbox(
                        activeColor: appTheme.blueGray300,
                        value: true,
                        shape: const CircleBorder(),
                        onChanged: (bool? value) {
                          setState(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 18.h),
                      child: Text(
                        "Task to do",
                        style: TextStyle(
                          color: appTheme.black90001,
                          fontSize: 15.fSize,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
