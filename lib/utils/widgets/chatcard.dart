import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messengerapp/screens/homescreen/controller.dart';
import 'package:messengerapp/utils/constants/colors.dart';

class ChatCard extends GetView<HomeController> {
  const ChatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10.h,
                  right: 10.h,
                  top: 10.h,
                ),
                child: TextField(
                  controller: controller.searchController,
                  onChanged: (value) {
                    controller.isSearching.value = true;
                    controller.searchKey.value = value;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.secondaryColor,
                    ),
                    fillColor: AppColors.appSecondaryColor,
                    filled: true,
                    hintText: "Search...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.h),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 7.h,
        ),
        Obx(
          () => Expanded(
            child: controller.loadChatRoomsView(),
          ),
        ),
      ],
    );
  }
}
