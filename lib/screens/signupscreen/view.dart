import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messengerapp/screens/signupscreen/controller.dart';
import 'package:messengerapp/utils/constants/colors.dart';
import 'package:messengerapp/utils/widgets/customsnackbar.dart';
import 'package:messengerapp/utils/widgets/customtextfield.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  void pickUserProfileImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      controller.uploadUserProfile(image);
    } else {
      customSnackBar("Unable to load Image!!!", "Please try again...");
    }
  }

  void handleSignUp() {
    controller.handleSignUp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => InkWell(
                  onTap: () => (controller.state.userProfileUrl.value != "")
                      ? {}
                      : pickUserProfileImage(),
                  child: (controller.state.userProfileUrl.value != "")
                      ? CircleAvatar(
                          radius: 45.h,
                          backgroundImage: NetworkImage(
                              controller.state.userProfileUrl.value),
                        )
                      : const Image(
                          image: AssetImage(
                            "assets/addprofileicon.png",
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomTextField(
                controller: controller.nameController,
                hintText: "Enter Username",
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextField(
                controller: controller.emailController,
                hintText: "Enter Email",
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextField(
                controller: controller.passwordController,
                hintText: "Enter Password",
                isPassword: true,
              ),
              SizedBox(
                height: 30.h,
              ),
              InkWell(
                onTap: () => handleSignUp(),
                child: Container(
                  height: 48.h,
                  width: 270.h,
                  decoration: BoxDecoration(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(20.h),
                  ),
                  child: Center(
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.h,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
