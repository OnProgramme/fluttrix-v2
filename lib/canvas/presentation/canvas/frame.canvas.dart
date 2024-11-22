import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/f.canvas.controller.dart';
import 'package:fluttrix/presentation/widgets/inputs/input.dropdown.dart';
import 'package:get/get.dart';

class FrameCanvas extends GetView<FCanvasController> {
  const FrameCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        constraints: BoxConstraints(
          maxWidth: 440,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: controller.handleSelectCanvas,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Page"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: 440,
              ),
              child: DeviceFrame(
                key: controller.frameKey,
                device: controller.currentDeviceInfo.value,
                orientation: Orientation.portrait,
                screen: controller.canvas.value.render(),
              ),
            )
          ],
        ),
      );
    });
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: controller.handleSelectCanvas,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Page"),
                          Icon(
                            Icons.back_hand_rounded,
                            size: 20,
                            color: Colors.black38,
                          )
                        ],
                      ),
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 1.3,
                    child: DeviceFrame(
                      key: controller.frameKey,
                      device: Devices.android.samsungGalaxyS20,
                      orientation: Orientation.portrait,
                      screen: controller.canvas.value.render(),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
