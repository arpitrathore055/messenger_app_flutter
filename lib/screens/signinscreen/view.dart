import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:messengerapp/screens/signinscreen/controller.dart';
import 'package:messengerapp/utils/constants/colors.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});

  void handleSignInWithGoogle() {
    controller.handleSignInWithGoogle();
  }

  void handleSignIn() {
    controller.handleSignIn();
  }

  void handleSignOut() {
    controller.handleSignOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
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
                "Let's chat",
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    fillColor: AppColors.appSecondaryColor,
                    filled: true,
                    hintText: "Enter Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.h),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: TextField(
                  obscureText: true,
                  controller: controller.passwordController,
                  decoration: InputDecoration(
                    fillColor: AppColors.appSecondaryColor,
                    filled: true,
                    hintText: "Enter Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.h),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () => handleSignIn(),
                child: Container(
                  height: 48.h,
                  width: 270.h,
                  decoration: BoxDecoration(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(20.h),
                  ),
                  child: Center(
                    child: Text(
                      "SignIn",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.h,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              const Text(
                "Sign In Using Social Networks",
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 30.h,
                ),
                child: SizedBox(
                  height: 40.h,
                  width: 90.h,
                  child: ElevatedButton(
                    onPressed: () => handleSignInWithGoogle(),
                    child: SvgPicture.asset("assets/googleicon.svg"),
                  ),
                ),
              ),
              /*Padding(
                padding: EdgeInsets.only(
                  top: 30.h,
                ),
                child: SizedBox(
                  height: 50.h,
                  width: 90.h,
                  child: ElevatedButton(
                    onPressed: () => handleSignOut(),
                    child: const Text(
                      "SignOut",
                      style: TextStyle(
                        color: AppColors.buttonColor,
                      ),
                    ),
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
