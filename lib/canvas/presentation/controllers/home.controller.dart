import 'package:flutter/material.dart';
import 'package:fluttrix/shared/navigation/application/router.dart';
import 'package:fluttrix/shared/navigation/routes.dart';
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
    AppRouter.navigate(Routes.PREVIEW_CODE);
  }
}
