import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.children.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.column.row.setting.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/f.canvas.controller.dart';
import 'package:get/get.dart';

class FTrixColumn extends FTrixWidgetUnScrollChildren {
  @override
  late WidgetType type;

  FTrixColumn({super.parentId, required this.setting}) {
    type = WidgetType.COLUMN;
    streamUpdate.listen(onWidgetUpdate(handleUpdateWidget));
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {}

  @override
  IWidget clone([String? parentId]) {
    return this;
  }


  @override
  Widget render() {
    final setting = this.setting as FTrixColumnRowSetting;
    final canvasWidth =
        Get.find<FCanvasController>().canvasSize.value.width;
    return FTrixBaseComponent(
      setting: setting,
      isSelected: isWidgetSelected,
      widget: this,
      onTap: select,
      key: ValueKey(id),
      onDrop: (e)=>handleDropWidget(e),
      constraints: children.isEmpty ? BoxConstraints(minHeight: 200, minWidth: canvasWidth) : null,
      child: Column(
        crossAxisAlignment: setting.crossAxisAlignment,
        mainAxisSize: setting.mainAxisSize,
        mainAxisAlignment: setting.mainAxisAlignment,
        children: children.map((c) => c.render()).toList(),
      ),
    );
  }

  @override
  void handleUpdateWidget(FTrixWidgetEventType type, IWidget widget) {
    // TODO: implement handleUpdateWidget
  }

  @override
  FTrixWidgetSetting setting;
}
