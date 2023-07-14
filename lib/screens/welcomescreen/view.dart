import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messengerapp/screens/welcomescreen/controller.dart';
import 'package:messengerapp/utils/constants/colors.dart';

class WelcomeScreen extends GetView<WelcomeController> {
  const WelcomeScreen({super.key});

  void handlePageChange(int index) {
    controller.handlePageChange(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            physics: const ClampingScrollPhysics(),
            controller: controller.pageController,
            reverse: false,
            onPageChanged: (value) => handlePageChange(value),
            children: controller.pageItemList,
          ),
          Obx(
            () => Positioned(
              bottom: 42.h,
              child: DotsIndicator(
                decorator: DotsDecorator(
                  activeColor: AppColors.buttonColor,
                ),
                dotsCount: controller.pageItemList.length,
                position: controller.state.pageIndex.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
