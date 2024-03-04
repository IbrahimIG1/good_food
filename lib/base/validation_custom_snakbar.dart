import 'package:flutter/material.dart';
import 'package:get/get.dart';

void show_custom_snakbar(String message,
    {bool error = true, String title = 'Error',Color color = Colors.red}) {
  Get.snackbar(title, message,
      titleText: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      messageText: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
      snackPosition: SnackPosition.TOP);
}
