import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messengerapp/screens/chatroomscreen/controller.dart';
import 'package:messengerapp/utils/constants/colors.dart';
import 'package:messengerapp/utils/constants/constants.dart';
import 'package:messengerapp/utils/widgets/customsnackbar.dart';

// ignore: must_be_immutable
class ChatRoomScreen extends GetView<ChatRoomController> {
  const ChatRoomScreen({super.key});

  void returnToChatScreen() {
    controller.exitChatScreen();
  }

  void sendMessage() {
    controller.addMessageToChatRoom();
  }

  void sendAttachments() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      controller.sendFile(image);
    } else {
      customSnackBar("Unable to load File!!!", "Please try again...");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.chatRoomBackground,
        appBar: AppBar(
          backgroundColor: AppColors.buttonColor,
          leading: IconButton(
            onPressed: () => returnToChatScreen(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Row(
            children: [
              CircleAvatar(
                radius: 18.h,
                backgroundImage: NetworkImage(
                  (controller.contactUserPhotoUrl.value == "")
                      ? defaultProfile
                      : controller.contactUserPhotoUrl.value,
                ),
              ),
              SizedBox(
                width: 6.h,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.state.contactUserName.value,
                    style: TextStyle(
                      fontSize: 12.h,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  /*(controller.contactUserStatus.value != "")
                      ? Text(
                          controller.contactUserStatus.value,
                          style: TextStyle(
                            fontSize: 10.h,
                            color: Colors.white,
                          ),
                        )
                      : Container(),*/
                  (controller.contactUserStatus.value == "offline")
                      ? Text(
                          "last seen at ${controller.lastSeenTime.value}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8.h,
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.video_call_sharp,
                size: 22.h,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.call,
                size: 22.h,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                size: 22.h,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            controller.loadMessages(),
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: AppColors.appSecondaryColor,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 6.h,
                  horizontal: 10.h,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.messageController,
                        decoration:
                            const InputDecoration(hintText: "message..."),
                      ),
                    ),
                    IconButton(
                      onPressed: () => sendAttachments(),
                      icon: Icon(
                        Icons.photo_outlined,
                        color: AppColors.buttonColor,
                        size: 26.h,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        foregroundColor: Colors.white,
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(2.h),
                        ),
                      ),
                      onPressed: () => sendMessage(),
                      child: const Text("Send"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
