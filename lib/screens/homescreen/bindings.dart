import 'package:get/get.dart';
import 'package:messengerapp/screens/homescreen/controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
