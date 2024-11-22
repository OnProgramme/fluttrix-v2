import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/f.canvas.controller.dart';
import 'package:fluttrix/canvas/presentation/canvas/frame.canvas.dart';
import 'package:fluttrix/canvas/presentation/toolbar/components/widgets.toolbar.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/toolbar.settings.component.dart';
import 'package:fluttrix/presentation/widgets/inputs/input.dropdown.dart';
import 'package:get/get.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // bindings: <ShortcutActivator, VoidCallback>{
    //   LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.delete): controller.handleListenerKeyboardEvent,
    //   LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.backspace): controller.handleListenerKeyboardEvent,
    // },
    final fCanvasController = Get.find<FCanvasController>();
    return Scaffold(
      body: Row(
        children: [
          WidgetsToolBar(),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  right: 10,
                  child: SizedBox(
                    width: 250,
                    child: InputDropdown(
                      label: "Device",
                      hint: "Sélectionner un appareil",
                      items:[ ...Devices.android.all, ...Devices.ios.all]
                          .map((d) => InputDropdownItem(d.name.capitalizeFirst!, d))
                          .toList(),
                      onChanged: fCanvasController.currentDeviceInfo.call,
                    ),
                  ),
                ),
                Center(child: FrameCanvas()),
              ],
            ),
          ),
          ToolbarSettingsComponent(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: controller.handlePreviewCode,
        child: Icon(
          Icons.code,
          color: Colors.white,
        ),
      ),
    );
  }
}
// bindings: <ShortcutActivator, VoidCallback>{
// const SingleActivator(LogicalKeyboardKey.arrowUp): () {
// setState(() => count = count + 1);
// },
// const SingleActivator(LogicalKeyboardKey.arrowDown): () {
// setState(() => count = count - 1);
// },
// },
