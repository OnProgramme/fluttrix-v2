import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/presentation/canvas/frame.canvas.dart';
import 'package:fluttrix/canvas/presentation/toolbar/components/widgets.toolbar.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/toolbar.settings.component.dart';
import 'package:get/get.dart';
import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          WidgetsToolBar(),
          Expanded(
            child: FrameCanvas(),
          ),
          ToolbarSettingsComponent(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: controller.handlePreviewCode,
        child: Icon(Icons.code, color: Colors.white,),
      ),
    );
  }
}
