import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messengerapp/firebase_options.dart';
import 'package:messengerapp/routes/names.dart';
import 'package:messengerapp/routes/pages.dart';
import 'package:messengerapp/services/config.dart';
import 'package:messengerapp/services/storageservices.dart';
import 'package:messengerapp/utils/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(StorageServices());
  Get.put(ConfigStore());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          ),
          initialRoute: (auth.currentUser != null)
              ? AppRoutes.homescreen
              : AppRoutes.initial,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
