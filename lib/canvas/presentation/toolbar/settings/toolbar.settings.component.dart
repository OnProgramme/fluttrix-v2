import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.button.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.image.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.text.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.textfield.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/ftrix.toolbar.settings.controller.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/button.toolbar.setting.component.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/image.toolbar.setting.component.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/text.toolbar.setting.component.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/textfield.toolbar.setting.component.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.size.dart';
import 'package:get/get.dart';

class ToolbarSettingsComponent extends GetView<FTrixToolbarSettingsController> {
  const ToolbarSettingsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Obx(
        () {
          return Column(
            children: [
              if(controller.selectedWidget.value is FTrixTextField)...[
              TextFieldToolBarSettingComponent(
                  widget: controller.selectedWidget.value as FTrixTextField
              )],
              if(controller.selectedWidget.value is FTrixButton)...[
                ButtonToolBarSettingComponent(
                    widget: controller.selectedWidget.value as FTrixButton
                )],
              if(controller.selectedWidget.value is FTrixText)...[
                TextToolBarSettingComponent(
                    widget: controller.selectedWidget.value as FTrixText
                )],
              if(controller.selectedWidget.value is FTrixImage)...[
                ImageToolBarSettingComponent(
                    widget: controller.selectedWidget.value as FTrixImage
                )],
            ],
          );
        }
      ),
    );
  }
}
