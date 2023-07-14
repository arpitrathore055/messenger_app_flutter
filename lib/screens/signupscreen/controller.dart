import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messengerapp/models/usermodel.dart';
import 'package:messengerapp/routes/pages.dart';
import 'package:messengerapp/screens/signupscreen/state.dart';
import 'package:messengerapp/services/storageservices.dart';
import 'package:messengerapp/utils/providers.dart';

class SignUpController extends GetxController {
  final SignUpState state = SignUpState();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void onInit() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.onInit();
  }

  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  Future<void> uploadUserProfile(XFile image) async {
    Reference ref = storage.ref().child("userprofile");
    UploadTask task = ref.putFile(File(image.path));
    TaskSnapshot snapShot = await task.whenComplete(() {});
    String userProfileUrl = await snapShot.ref.getDownloadURL();
    state.userProfileUrl.value = userProfileUrl;
  }

  void handleSignUp() async {
    if (_emailController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        state.userProfileUrl.value != "") {
      await auth
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then(
        (value) async {
          UserModel user = UserModel(
              userDisplayName: _nameController.text,
              userEmail: _emailController.text,
              userId: auth.currentUser!.uid,
              userPhotoUrl: state.userProfileUrl.value,
              status: "online");
          await firestore
              .collection("users")
              .doc(user.userId)
              .set(user.toJson());

          StorageServices.to.setString("username", user.userDisplayName);
          StorageServices.to.setString("useremail", user.userEmail);
          StorageServices.to.setString("userid", user.userId);
          StorageServices.to.setString("userprofile", user.userPhotoUrl);
          Get.offAndToNamed(AppPages.signIn);
        },
      );
    }
  }
}
