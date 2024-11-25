import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/f.canvas.controller.dart';
import 'package:fluttrix/canvas/presentation/canvas/frame.canvas.dart';
import 'package:fluttrix/canvas/presentation/canvas/tree/canvas.tree.widget.dart';
import 'package:fluttrix/canvas/presentation/toolbar/components/widgets.toolbar.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/toolbar.settings.component.dart';
import 'package:fluttrix/utils/app.colors.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 3),
            height: 60,
            width: MediaQuery.sizeOf(context).width,
            color: AppColors.primary,
          ),
          Expanded(
            child: Row(
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      margin: EdgeInsets.only(right: 3),
                      height: MediaQuery.sizeOf(context).height,
                      color: AppColors.primary,
                      child: Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                controller.currentIndex(0);
                              },
                              icon: Icon(LucideIcons.layoutList)),
                          IconButton(
                              onPressed: () {
                                controller.currentIndex(1);
                              },
                              icon: Icon(LucideIcons.folderTree))
                        ],
                      ),
                    ),
                    Obx(
                      () => IndexedStack(
                        index: controller.currentIndex.value,
                        children: [
                          WidgetsToolBar(),
                          WidgetExplorerPanel(
                            rootWidget: fCanvasController.canvas.value
                                .getSelectedWidget(),
                            onWidgetSelected: (p0) {},
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: FrameCanvas(),
                ),
                ToolbarSettingsComponent(),
              ],
            ),
          ),
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
