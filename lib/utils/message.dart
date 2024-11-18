// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class Message {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void errors(String msg, {IconData? iconData}) {
    _showSnackBar(
      msg,
      _MessageType.errors,
      Icon(
        iconData ?? Icons.error_outline,
        color: Colors.white,
        size: 35,
      ),
    );
  }

  static void success(String msg, {IconData? iconData}) {
    _showSnackBar(
      msg,
      _MessageType.success,
      Icon(
        iconData ?? Icons.check_circle,
        color: Colors.white,
        size: 35,
      ),
    );
  }

  static _showSnackBar(String msg, _MessageType type, Widget? icon) {
    showToastWidget(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _snackbarColor(type),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          msg,
          style: Get.textTheme.bodyMedium?.copyWith(
            fontSize: 15,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      duration: const Duration(seconds: 5),
      position: ToastPosition.top,
    );
    // Timer(
    //   const Duration(milliseconds: 200),
    //   () {
    //     Get.showSnackbar(GetSnackBar(
    //       icon: icon,
    //       snackPosition: SnackPosition.TOP,
    //       messageText: Text(
    //         msg,
    //         style: Get.textTheme.displaySmall
    //             ?.copyWith(color: AppColors.white, fontSize: 18),
    //       ),
    //       backgroundColor: _snackbarColor(type),
    //       duration: const Duration(seconds: 30, milliseconds: 500),

    //     ));
    //   },
    // );
  }

  static Color _snackbarColor(_MessageType type) {
    switch (type) {
      case _MessageType.errors:
        return Colors.redAccent;
      default:
        return Colors.green;
    }
  }

  static test(String msg) {}
}

enum _MessageType { success, errors, warning }
