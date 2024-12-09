import 'package:device_frame/device_frame.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttrix/canvas/models/utils/data.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.canvas.dart';
import 'package:get/get.dart';

class FCanvasControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<FCanvasController>(
      () => FCanvasController(),
    );
  }
}

class FCanvasController extends GetxController {
  final canvas = FTrixCanvas();
  final canvasSize = Rx(Size.zero);
  final frameKey = GlobalKey();
  final currentDeviceInfo = Devices.ios.iPhone13ProMax.obs;
  final isThreeOpened = true.obs;

  @override
  void onInit() {
    super.onInit();
    canvas.loadFromJson(localData);
    WidgetsBinding.instance.addPostFrameCallback((t){
      final RenderBox renderBox =
      frameKey.currentContext?.findRenderObject() as RenderBox;
      canvasSize.value = renderBox.size;
    });
  }


  void handleSelectCanvas() {
    canvas.select();
  }
}