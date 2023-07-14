import 'package:get/get.dart';
import 'package:messengerapp/screens/chatroomscreen/controller.dart';

class ChatRoomBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatRoomController());
  }
}
