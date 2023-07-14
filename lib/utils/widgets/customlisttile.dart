import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messengerapp/screens/homescreen/controller.dart';
import 'package:messengerapp/utils/constants/colors.dart';

class CustomListTile extends GetView<HomeController> {
  final String title;
  final IconData icon;
  final bool isLogout;
  const CustomListTile(
      {required this.title,
      this.isLogout = false,
      required this.icon,
      super.key});

  void handleLogOut() {
    controller.handleSignOut();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => (isLogout) ? handleLogOut() : {},
      contentPadding: EdgeInsets.all(3.h),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 14.h,
        ),
      ),
      trailing: (isLogout)
          ? const Text("")
          : IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.secondaryColor,
              ),
            ),
      leading: Icon(
        icon,
        size: 24.h,
      ),
      iconColor: AppColors.secondaryColor,
    );
  }
}
