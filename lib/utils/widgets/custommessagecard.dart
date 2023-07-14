import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messengerapp/screens/chatroomscreen/controller.dart';
import 'package:messengerapp/utils/constants/colors.dart';

class CustomMessageCard extends GetView<ChatRoomController> {
  final bool isReceived;
  final String message;
  // ignore: prefer_typing_uninitialized_variables
  final messageSentTime;
  const CustomMessageCard(
      {required this.message,
      required this.messageSentTime,
      required this.isReceived,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: 230.h,
          ),
          margin: EdgeInsets.all(5.h),
          padding:
              EdgeInsets.only(top: 12.h, bottom: 12.h, left: 12.h, right: 55.h),
          decoration: BoxDecoration(
            color: (isReceived) ? Colors.white : AppColors.buttonColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.h),
              bottomRight: Radius.circular(10.h),
              topLeft:
                  (isReceived) ? Radius.circular(0.h) : Radius.circular(10.h),
              topRight:
                  (isReceived) ? Radius.circular(10.h) : Radius.circular(0.h),
            ),
          ),
          child: Text(
            message,
            style: TextStyle(
              fontSize: 12.h,
              color: (isReceived) ? Colors.black : Colors.white,
            ),
          ),
        ),
        Positioned(
            right: 10.h,
            bottom: 8.h,
            child: Text(
              messageSentTime.toString(),
              style: TextStyle(
                  fontSize: 10.h,
                  color:
                      (!isReceived) ? Colors.white : AppColors.secondaryColor),
            )),
      ],
    );
  }
}
