import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/f.canvas.controller.dart';
import 'package:fluttrix/canvas/presentation/canvas/tree/canvas.tree.widget.dart';
import 'package:fluttrix/utils/app.colors.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FrameCanvas extends GetView<FCanvasController> {
  const FrameCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          SingleChildScrollView(
            child: InteractiveViewer(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 390,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: controller.handleSelectCanvas,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20)
                                  .copyWith(left: 0),
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
                      Theme(
                        data: ThemeData(
                            textTheme: TextTheme(
                          bodyLarge: TextStyle(color: Colors.black),
                          bodyMedium: TextStyle(color: Colors.black),
                          bodySmall: TextStyle(color: Colors.black),
                        )),
                        child: SizedBox(
                          key: controller.frameKey,
                          height: 840,
                          width: 390,
                          child: controller.canvas.value.render(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              left: controller.isThreeOpened.value ? 0 : -304,
              bottom: 0,
              top: 0,
              duration: Duration(milliseconds: 200),
              child: SizedBox(
                width: 350,
                height: MediaQuery.sizeOf(context).height,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: WidgetExplorerPanel(
                        rootWidget: controller.canvas.value.getSelectedWidget(),
                        onWidgetSelected: (p0) {},
                      ),
                    ),
                    SizedBox(width: 3),
                    MaterialButton(
                      minWidth: 0,
                      elevation: 0,
                      shape: CircleBorder(),
                      color: AppColors.primary,
                      onPressed: () {
                        controller.isThreeOpened.value =
                            !controller.isThreeOpened.value;
                      },
                      padding: EdgeInsets.all(20),
                      child: Icon(
                        LucideIcons.folderTree,
                        color: Colors.white,
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
