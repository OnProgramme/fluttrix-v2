import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.button.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/f.canvas.controller.dart';
import 'package:get/get.dart';

class FrameCanvas extends GetView<FCanvasController> {
  const FrameCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 900,
      child: Obx(
        ()=>DeviceFrame(
          device: Devices.ios.iPhone13ProMax,
          orientation: Orientation.portrait,
          screen: controller.canvas.value.render(),
        )
      ),
    );
  }
}
