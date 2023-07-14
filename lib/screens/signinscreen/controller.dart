import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messengerapp/routes/pages.dart';
import 'package:messengerapp/screens/signinscreen/state.dart';
import 'package:messengerapp/services/storageservices.dart';
import 'package:messengerapp/utils/providers.dart';
import 'package:messengerapp/utils/widgets/customsnackbar.dart';

class SignInController extends GetxController {
  final SignInState state = SignInState();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void onInit() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.onInit();
  }

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  void handleSignInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      var userCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      auth.signInWithCredential(userCredential);
      StorageServices.to.loadUserInfo(auth.currentUser!.uid);
      //storeUserInfo(auth.currentUser!.uid);
      Get.offAndToNamed(AppPages.homescreen);
    } catch (e) {
      Get.snackbar("SignIn Failed!!!", e.toString());
    }
  }

  void handleSignIn() async {
    state.userEmail.value = _emailController.text;
    state.userPassword.value = _passwordController.text;
    if (state.userEmail.value.isNotEmpty &&
        state.userPassword.value.isNotEmpty) {
      try {
        await auth
            .signInWithEmailAndPassword(
                email: state.userEmail.value,
                password: state.userPassword.value)
            .then(
          (value) {
            _emailController.clear();
            _passwordController.clear();
            state.userEmail.value = "";
            state.userPassword.value = "";
            StorageServices.to.loadUserInfo(auth.currentUser!.uid);
            //storeUserInfo(auth.currentUser!.uid);
            Get.offAndToNamed(AppPages.homescreen);
          },
        );
      } catch (e) {
        customSnackBar("Account Not Found!!!", "Please Create a New Account");
      }
    } else {
      customSnackBar("SignIn Failed!!!", "Please Fill all The Fields");
    }
  }

  /*void storeUserInfo(String userId) async {
    await firestore.collection("users").doc(userId).get().then((snapshot) {
      StorageServices.to
          .setString("username", snapshot.data()!["userDisplayName"]);
      StorageServices.to.setString("useremail", snapshot.data()!["userEmail"]);
      StorageServices.to.setString("userid", snapshot.data()!["userId"]);
      StorageServices.to
          .setString("userprofile", snapshot.data()!["userPhotoUrl"]);
    });
  }*/

  void handleSignOut() {
    googleSignIn.signOut();
  }
}
