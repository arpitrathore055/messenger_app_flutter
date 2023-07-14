import 'package:get/get.dart';
import 'package:messengerapp/screens/signupscreen/controller.dart';

class SignUpBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}
