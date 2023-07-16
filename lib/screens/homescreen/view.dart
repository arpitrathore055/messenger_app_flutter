import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messengerapp/screens/homescreen/controller.dart';
import 'package:messengerapp/utils/constants/colors.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  void onIndexChange(int index) {
    controller.handleNavIndexChange(index);
  }

  void changeTheme() {
    controller.changeAppTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: (controller.isDarkTheme.value)
              ? Colors.black.withOpacity(0.0)
              : Colors.white,
          elevation: 0.0,
          title: Text(
            controller.tabTitleList[controller.state.bottomNavIndex.value],
            style: TextStyle(
              color: (controller.isDarkTheme.value)
                  ? Colors.white
                  : AppColors.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          actions: [
            (controller.isDarkTheme.value)
                ? IconButton(
                    onPressed: () => changeTheme(),
                    icon: const Icon(
                      Icons.sunny,
                      color: AppColors.secondaryColor,
                    ),
                  )
                : IconButton(
                    onPressed: () => changeTheme(),
                    icon: const Icon(
                      Icons.dark_mode,
                      color: AppColors.secondaryColor,
                    ),
                  )
          ],
        ),
        body: PageView(
          controller: controller.pageController,
          //scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          children: controller.pageContent,
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.0,
          items: controller.bottomNavItemList,
          currentIndex: controller.state.bottomNavIndex.value,
          selectedItemColor: (controller.isDarkTheme.value)
              ? Colors.white
              : AppColors.buttonColor,
          showUnselectedLabels: false,
          onTap: (index) => onIndexChange(index),
        ),
      ),
    );
  }
}
