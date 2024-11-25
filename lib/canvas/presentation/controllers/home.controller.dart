import 'package:flutter/material.dart';
import 'package:fluttrix/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final focusNode = FocusNode();
  final currentIndex = 0.obs;

  @override
  void onClose() {
    super.onClose();
    focusNode.dispose();
  }

  void handlePreviewCode() {
    Get.toNamed(Routes.PREVIEW_CODE);
  }
}
