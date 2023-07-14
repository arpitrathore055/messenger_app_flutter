import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController customSnackBar(String title, String message) {
  return Get.snackbar(
    title,
    message,
    icon: const Icon(
      Icons.error,
      color: Colors.black,
    ),
    colorText: Colors.black,
    backgroundGradient: const LinearGradient(
      colors: [
        Colors.teal,
        Colors.tealAccent,
      ],
    ),
    isDismissible: true,
  );
}
