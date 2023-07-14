import 'package:get/get.dart';
import 'package:messengerapp/screens/welcomescreen/controller.dart';

class WelcomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeController());
  }
}
