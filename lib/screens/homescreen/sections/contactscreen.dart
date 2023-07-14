import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messengerapp/screens/homescreen/controller.dart';

class ContactScreen extends GetView<HomeController> {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: controller.loadContactRoomsView(),
        ),
      ],
    );
  }
}
