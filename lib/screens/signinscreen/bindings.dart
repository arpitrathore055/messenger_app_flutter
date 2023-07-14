import 'package:get/get.dart';
import 'package:messengerapp/screens/signinscreen/controller.dart';

class SignInBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }
}
