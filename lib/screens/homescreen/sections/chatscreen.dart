import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messengerapp/screens/homescreen/controller.dart';
import 'package:messengerapp/utils/widgets/chatcard.dart';

class ChatScreen extends GetView<HomeController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (controller.state.isChatRoomLoading.value)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : const ChatCard(),
    );
  }
}
