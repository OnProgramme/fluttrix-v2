import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.children.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.wrap.setting.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/f.canvas.controller.dart';
import 'package:get/get.dart';

class FTrixWrap extends FTrixWidgetWithChildren {
  FTrixWrap({super.parentId, FTrixWrapSetting? setting})
      : super(type: WidgetType.WRAP, setting: setting ?? FTrixWrapSetting.zero);

  @override
  void loadFromJson(Map<String, dynamic> json) {}

  @override
  IWidget clone([String? parentId]) {
    return this;
  }

  @override
  Widget render() {
    final setting = this.setting as FTrixWrapSetting;
    final canvasWidth = Get.find<FCanvasController>().canvasSize.value.width;
    return FTrixBaseComponent(
      setting: setting,
      isSelected: isWidgetSelected,
      widget: this,
      onTap: select,
      key: ValueKey(id),
      onDrop: (e) => handleDropWidget(e),
      constraints: BoxConstraints(minHeight: 200, minWidth: canvasWidth),
      child: Wrap(
        crossAxisAlignment: setting.crossAxisAlignment,
        alignment: setting.alignment,
        spacing: setting.spacing,
        direction: setting.direction,
        runSpacing: setting.runSpacing,
        runAlignment: setting.runAlignment,
        children: children.map((c) => c.render()).toList(),
      ),
    );
  }
}
