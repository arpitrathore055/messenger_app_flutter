import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:messengerapp/routes/pages.dart';
import 'package:messengerapp/screens/homescreen/sections/contactscreen.dart';
import 'package:messengerapp/screens/homescreen/sections/profilescreen.dart';
import 'package:messengerapp/screens/homescreen/state.dart';
import 'package:messengerapp/services/storageservices.dart';
import 'package:messengerapp/utils/constants/colors.dart';
import 'package:messengerapp/utils/constants/constants.dart';
import 'package:messengerapp/utils/providers.dart';
import 'package:messengerapp/utils/widgets/chatcard.dart';
import 'package:messengerapp/utils/widgets/customcontactlist.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  final HomeState state = HomeState();
  late TextEditingController _searchController;

  late PageController _pageController;
  final isSearching = false.obs;
  final searchKey = "".obs;
  final isContactsLoading = true.obs;
  final isDarkTheme = false.obs;
  final isProfileLoading = true.obs;
  List<Contact> _contactUserList = [];
  late List<String> _tabTitleList;
  late List<Widget> _pageContent;
  late List<BottomNavigationBarItem> _bottomNavItemList;

  @override
  void onInit() async {
    _tabTitleList = const [
      "Chats",
      "Contacts",
      "Profile",
    ];
    _searchController = TextEditingController();
    _pageController = PageController(viewportFraction: 1);
    _bottomNavItemList = const [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.message,
        ),
        label: "Chats",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.contacts,
        ),
        label: "Contacts",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
        ),
        label: "Profile",
      ),
    ];

    _pageContent = [
      Obx(
        () => (state.isChatRoomLoading.value)
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.buttonColor,
                ),
              )
            : const ChatCard(),
      ),
      const ContactScreen(),
      const ProfileScreen(),
    ];
    //state.isChatRoomLoading.value = false;
    await StorageServices.to.loadUserInfo(auth.currentUser!.uid);
    getContactAccessPermission();
    super.onInit();
  }

  PageController get pageController => _pageController;
  TextEditingController get searchController => _searchController;
  List<BottomNavigationBarItem> get bottomNavItemList => _bottomNavItemList;
  List<Widget> get pageContent => _pageContent;
  List<String> get tabTitleList => _tabTitleList;
  List<Contact> get contactUserList => _contactUserList;

  getContactAccessPermission() async {
    if (await Permission.contacts.isGranted) {
      fetchContactUserList();
      isContactsLoading.value = false;
    } else {
      await Permission.contacts.request();
    }
  }

  fetchContactUserList() async {
    _contactUserList = await ContactsService.getContacts();
  }

  void handleSignOut() {
    StorageServices.to.sharedPrefs.clear();
    auth.signOut();
    Get.offAndToNamed(AppPages.signIn);
  }

  void changeAppTheme() {
    isDarkTheme.value = !isDarkTheme.value;
    Get.changeTheme(
        (!isDarkTheme.value) ? ThemeData.light() : ThemeData.dark());
  }

  void handleNavIndexChange(int index) {
    state.bottomNavIndex.value = index;
    _pageController.jumpToPage(index);
  }

  void loadChatRoom(String chatRoomId) {
    Get.toNamed(AppPages.chatRoom, arguments: chatRoomId);
  }

  Future<void> createChatRoom(String chatRoomId, String contactUserName) async {
    await firestore.collection("chatrooms").doc(chatRoomId).set(
      {
        "chatroomid": chatRoomId,
        "users": [StorageServices.to.getString("username"), contactUserName],
        "lastmsg": "",
        "lasttime": "",
        "lastseen": "",
      },
    );
  }

  Future<void> initializeChatRoom(String contactUserName) async {
    String chatRoomId = "";
    chatRoomId = createChatRoomId(contactUserName);
    var snapshot =
        await firestore.collection("chatrooms").doc(chatRoomId).get();
    if (snapshot.data() == null) {
      createChatRoom(chatRoomId, contactUserName);
    }
    Get.toNamed(AppPages.chatRoom, arguments: chatRoomId);
  }

  String createChatRoomId(String contactUserName) {
    if (StorageServices.to.getString("username")[0].codeUnitAt(0) <
        contactUserName[0].codeUnitAt(0)) {
      return "${contactUserName}_${StorageServices.to.getString("username")}";
    } else {
      return "${contactUserName}_${StorageServices.to.getString("username")}";
    }
  }

  Future<String> getContactUserProfile(String contactUserName) async {
    await firestore
        .collection("users")
        .where("userDisplayName", isEqualTo: contactUserName)
        .get()
        .then((snapshot) {
      isProfileLoading.value = false;
      return snapshot.docs[0]["userPhotoUrl"];
    });
    return defaultProfile;
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> loadChatRoomsView() {
    return StreamBuilder(
      stream: (searchKey.value == "")
          ? firestore
              .collection("chatrooms")
              .where("users",
                  arrayContains: StorageServices.to.getString("username"))
              .snapshots()
          : firestore
              .collection("chatrooms")
              .where("chatroomid", isEqualTo: createChatRoomId(searchKey.value))
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            var chatRooms = snapshot.data!.docs;
            isProfileLoading.value = true;
            return ListView.builder(
              itemCount: chatRooms.length,
              itemBuilder: (context, index) {
                var contactUserProfile = getContactUserProfile(chatRooms[index]
                            ["users"][0] ==
                        StorageServices.to.getString("username")
                    ? chatRooms[index]["users"][1]
                    : chatRooms[index]["users"][0]);
                return (chatRooms[index]["lastmsg"] != "")
                    ? ListTile(
                        trailing: Padding(
                          padding: EdgeInsets.only(bottom: 15.h, right: 10.h),
                          child: Text(
                            DateFormat('h:mm:a')
                                .format(chatRooms[index]["lasttime"].toDate())
                                .toString(),
                          ),
                        ),
                        contentPadding: EdgeInsets.all(6.h),
                        onTap: () =>
                            loadChatRoom(chatRooms[index]["chatroomid"]),
                        leading: CircleAvatar(
                          radius: 26.h,
                          backgroundImage: NetworkImage(
                            (isProfileLoading.value)
                                ? defaultProfile
                                : contactUserProfile.toString(),
                          ),
                        ),
                        title: Text(
                          chatRooms[index]["users"][0] ==
                                  StorageServices.to.getString("username")
                              ? chatRooms[index]["users"][1]
                              : chatRooms[index]["users"][0],
                          style: TextStyle(
                            fontSize: 15.h,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(chatRooms[index]["lastmsg"].toString()),
                      )
                    : Container();
              },
            );
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> loadContactRoomsView() {
    return StreamBuilder(
      stream: firestore
          .collection("users")
          .where("userDisplayName",
              isNotEqualTo: StorageServices.to.getString("username"))
          .orderBy("userDisplayName", descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            var contactList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () =>
                      initializeChatRoom(contactList[index]["userDisplayName"]),
                  contentPadding: EdgeInsets.all(
                    6.h,
                  ),
                  leading: CircleAvatar(
                    radius: 25.h,
                    //backgroundColor: AppColors.buttonColor,
                    backgroundImage: const NetworkImage(defaultProfile),
                    // child: Text(
                    //   contactList[index]["userDisplayName"].substring(0, 1),
                    //   style: TextStyle(
                    //     fontSize: 25.h,
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ),
                  title: Text(
                    contactList[index]["userDisplayName"],
                    style: TextStyle(
                      fontSize: 15.h,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            );
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  loadContactUserList() {
    return (isContactsLoading.value)
        ? Center(
            child: CircularProgressIndicator(
              color: AppColors.buttonColor,
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: _contactUserList.length,
            itemBuilder: (context, index) {
              var contactUser = _contactUserList[index];
              return CustomContactList(contactUserDetails: contactUser);
            },
          );
  }
}
