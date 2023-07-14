import 'package:get/get.dart';
import 'package:messengerapp/services/storageservices.dart';

class ConfigStore extends GetxController {
  static ConfigStore get to => Get.find();
  bool isFirstOpen = false;
  bool isDarkTheme = false;

  Future<bool> saveALreadyOpen() async {
    return await StorageServices.to
        .setBool("STORAGE_DEVICE_FIRST_OPEN_KEY", true);
  }
}
