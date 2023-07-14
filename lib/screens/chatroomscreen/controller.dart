import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:messengerapp/screens/chatroomscreen/state.dart';
import 'package:messengerapp/services/storageservices.dart';
import 'package:messengerapp/utils/constants/colors.dart';
import 'package:messengerapp/utils/providers.dart';
import 'package:messengerapp/utils/widgets/custommessagecard.dart';

class ChatRoomController extends GetxController {
  var contactUserPhotoUrl = "".obs;
  var contactUserStatus = "".obs;
  var lastSeenTime = "".obs;

  final ChatRoomState state = ChatRoomState();
  late TextEditingController _messageController;
  @override
  void onInit() async {
    _messageController = TextEditingController();
    state.chatRoomId.value = Get.arguments;
    await firestore
        .collection("chatrooms")
        .doc(state.chatRoomId.value)
        .get()
        .then(
      (snapshot) {
        state.contactUserName.value = snapshot.data()!["users"][0] ==
                StorageServices.to.getString("username")
            ? snapshot.data()!["users"][1]
            : snapshot.data()!["users"][0];
        lastSeenTime.value = DateFormat('h:mm a')
            .format(DateTime.fromMillisecondsSinceEpoch(
                snapshot.data()!["lastseen"]))
            .toString();
      },
    );
    var contactUser = await firestore
        .collection("users")
        .where("userDisplayName", isEqualTo: state.contactUserName.value)
        .get();
    contactUserPhotoUrl.value = contactUser.docs[0]["userPhotoUrl"];
    super.onInit();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  TextEditingController get messageController => _messageController;

  /*getContactUserStatus() async {
    return StreamBuilder(
      stream: firestore.collection("users").where("userDisplayName",isEqualTo: state.contactUserName.value).snapshots(),
      builder: (context,index){

      },
    );
  }*/

  loadMessages() {
    return StreamBuilder(
      stream: firestore
          .collection("chatrooms")
          .doc(state.chatRoomId.value)
          .collection("chats")
          .orderBy("sentDate", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final chats = snapshot.data!.docs;
          return Padding(
            padding: EdgeInsets.only(
              bottom: 52.h,
            ),
            child: ListView.builder(
              reverse: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                var date = chats[index]["sentDate"];
                return Align(
                  alignment:
                      (chats[index]["sentBy"] == state.contactUserName.value)
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                  child: CustomMessageCard(
                    isReceived:
                        (chats[index]["sentBy"] == state.contactUserName.value)
                            ? true
                            : false,
                    message: chats[index]["message"],
                    messageSentTime: DateFormat('h:mm a')
                        .format(DateTime.fromMillisecondsSinceEpoch(date)),
                  ),
                );
              }),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.buttonColor,
          ),
        );
      },
    );
  }

  addMessageToChatRoom() async {
    if (_messageController.text.isNotEmpty) {
      await firestore
          .collection("chatrooms")
          .doc(state.chatRoomId.value)
          .collection("chats")
          .doc()
          .set({
        "message": _messageController.text,
        "sentBy": StorageServices.to.getString("username"),
        "sentDate": DateTime.now().millisecondsSinceEpoch,
      });
      await firestore
          .collection("chatrooms")
          .doc(state.chatRoomId.value)
          .update({
        "lastmsg": _messageController.text,
        "lasttime": DateTime.now(),
        "lastmsgsentby": StorageServices.to.getString("username"),
        "lastseen": "",
      });
      _messageController.clear();
    }
  }

  Future<void> sendFile(XFile attachment) async {
    Reference ref =
        storage.ref().child("attachments/images/${attachment.name}");
    UploadTask task = ref.putFile(File(attachment.path));
    TaskSnapshot snapshot = await task.whenComplete(() {});
    // ignore: unused_local_variable
    String attachmentUrl = await snapshot.ref.getDownloadURL();
  }

  void exitChatScreen() async {
    await firestore
        .collection("chatrooms")
        .doc(state.chatRoomId.value)
        .update({"lastseen": DateTime.now().millisecondsSinceEpoch});
    Get.back();
  }
}
