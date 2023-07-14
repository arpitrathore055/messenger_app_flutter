import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:messengerapp/routes/pages.dart';
import 'package:messengerapp/screens/welcomescreen/state.dart';
import 'package:messengerapp/services/config.dart';
import 'package:messengerapp/utils/constants/colors.dart';

class WelcomeController extends GetxController {
  final WelcomeState state = WelcomeState();
  late PageController _pageController;
  late List<Widget> _pageItemList;

  @override
  void onInit() {
    _pageController = PageController();
    _pageItemList = [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icon192.svg",
            height: 120.h,
            width: 120.h,
          ),
          SizedBox(
            height: 10.h,
          ),
          const Text(
            "Connect anyone from anywhere",
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/messageicon.svg",
            height: 120.h,
            width: 120.h,
          ),
          SizedBox(
            height: 10.h,
          ),
          const Text(
            "Sent Free Messages",
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Free Download Message Mail SVG vector file",
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/messageicon.svg",
                height: 120.h,
                width: 120.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              const Text(
                "Sent Free Messages",
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Free Download Message Mail SVG vector file",
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 80.h,
            child: Row(
              children: [
                SizedBox(
                  height: 50.h,
                  width: 90.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: AppColors.buttonColor,
                    ),
                    onPressed: () => handleLogIn(),
                    child: const Text(
                      "Login",
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.h,
                ),
                SizedBox(
                  height: 50.h,
                  width: 90.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: AppColors.buttonColor,
                    ),
                    onPressed: () => handleSignUp(),
                    child: const Text(
                      "Sign Up",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ];
    super.onInit();
  }

  PageController get pageController => _pageController;
  List<Widget> get pageItemList => _pageItemList;

  void handlePageChange(int index) {
    state.pageIndex.value = index;
    onPageChange(state.pageIndex.value);
  }

  void onPageChange(int index) {
    _pageController.jumpToPage(index);
  }

  void handleLogIn() {
    ConfigStore.to.isFirstOpen = true;
    Get.offAndToNamed(AppPages.signIn);
  }

  void handleSignUp() {
    Get.offAndToNamed(AppPages.signUp);
  }
}
