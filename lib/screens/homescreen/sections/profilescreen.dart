import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:messengerapp/services/storageservices.dart';
import 'package:messengerapp/utils/constants/colors.dart';
import 'package:messengerapp/utils/widgets/customlisttile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.h,
        top: 5.h,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 25.h,
                    //backgroundColor: AppColors.buttonColor,
                    backgroundImage: NetworkImage(
                        StorageServices.to.getString("userprofile")),
                    child: Text(
                      StorageServices.to.getString("username").substring(0, 1),
                      style: TextStyle(
                        fontSize: 25.h,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StorageServices.to.getString("username"),
                    style: TextStyle(
                      fontSize: 15.h,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "ID: ${StorageServices.to.getString("userid")}",
                    style: const TextStyle(
                      //fontSize: 15.h,
                      //fontWeight: FontWeight.w700,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          const CustomListTile(
            title: "Account",
            icon: Icons.account_box,
          ),
          const CustomListTile(
            title: "Chat",
            icon: Icons.chat,
          ),
          const CustomListTile(
            title: "Notification",
            icon: Icons.notifications_active,
          ),
          const CustomListTile(
            title: "Privacy",
            icon: Icons.privacy_tip,
          ),
          const CustomListTile(
            title: "Help",
            icon: Icons.help_center_outlined,
          ),
          const CustomListTile(
            title: "Logout",
            icon: Icons.logout,
            isLogout: true,
          ),
        ],
      ),
    );
  }
}
