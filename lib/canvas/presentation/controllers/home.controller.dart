import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.stream.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final focusNode = FocusNode();
  IWidget? selectedWidget;
  @override
  void onInit() {
    super.onInit();
    FTrixStream.instance.stream.listen((event) {
      if (event.type == FTrixWidgetEventType.SELECT) {
        selectedWidget = event.widget;
      } else {
        selectedWidget = null;
      }
    });
  }


  @override
  void onClose() {
    super.onClose();
    focusNode.dispose();
  }

  void handlePreviewCode() {
    Get.toNamed(Routes.PREVIEW_CODE);
  }

  void handleListenerKeyboardEvent(KeyEvent event) {
    if (event is KeyUpEvent || !kIsWeb) return;
    final userAgent = html.window.navigator.userAgent.toLowerCase();

    if ((userAgent.contains('macintosh') &&
            event.logicalKey == LogicalKeyboardKey.backspace ||
        event.logicalKey == LogicalKeyboardKey.delete) && selectedWidget != null) {
      selectedWidget!.delete();
    }
  }
}
