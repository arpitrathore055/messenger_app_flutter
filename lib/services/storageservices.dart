import 'package:get/get.dart';
import 'package:messengerapp/utils/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServices extends GetxController {
  static StorageServices get to => Get.find();
  late SharedPreferences sharedPrefs;

  @override
  void onInit() async {
    //onInit() runs as soon as the controller is called
    sharedPrefs = await SharedPreferences.getInstance();
    super.onInit();
  }

  Future<void> loadUserInfo(String userId) async {
    await firestore.collection("users").doc(userId).get().then((snapshot) {
      sharedPrefs.setString("username", snapshot.data()!["userDisplayName"]);
      sharedPrefs.setString("useremail", snapshot.data()!["userEmail"]);
      sharedPrefs.setString("userid", snapshot.data()!["userId"]);
      sharedPrefs.setString("userprofile", snapshot.data()!["userPhotoUrl"]);
    });
  }

  Future<bool> setString(String key, String value) async {
    //whenever we set something using sharedPreferences then it returns us with a bool value whether true or false
    return await sharedPrefs.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await sharedPrefs.setBool(key, value);
  }

  Future<bool> setList(String key, List<String> value) async {
    return await sharedPrefs.setStringList(key, value);
  }

  String getString(String key) {
    //whenever we try to get some value with respect to key using sharedPreferences then there is no reqiurement of await and async
    return sharedPrefs.getString(key) ?? "";
  }

  bool getBool(String key) {
    return sharedPrefs.getBool(key) ?? false;
  }

  List<String> getStringList(String key) {
    return sharedPrefs.getStringList(key) ?? [];
  }
}
