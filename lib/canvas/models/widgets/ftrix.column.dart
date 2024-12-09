import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.children.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.column.row.setting.dart';
import 'package:fluttrix/canvas/models/utils/normalize.json.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/f.canvas.controller.dart';
import 'package:get/get.dart';

class FTrixColumn extends FTrixWidgetWithChildren {
  FTrixColumn({
    super.parentId,
    FTrixColumnRowSetting? setting,
    super.children,
  }) : super(
          setting: setting ?? FTrixColumnRowSetting.zero,
          type: WidgetType.COLUMN,
        );

  @override
  void loadFromJson(Map<String, dynamic> json) {
    setting = FTrixColumnRowSetting.fromJson(normalizeJson(json['setting']));
  }

  @override
  IWidget clone([String? parentId]) {
    return FTrixColumn(
      parentId: parentId ?? this.parentId,
      setting: FTrixColumnRowSetting.fromJson(setting.toJson()),
      children: children.map((el) => el.clone()).toList()
    );
  }

  @override
  Widget render() {
    final setting = this.setting as FTrixColumnRowSetting;
    final canvasWidth = Get.find<FCanvasController>().canvasSize.value.width;
    return FTrixBaseComponent(
      setting: setting,
      isSelected: isWidgetSelected,
      widget: this,
      onTap: select,
      key: ValueKey(id),
      onDrop: handleDropWidget,
      constraints: children.isEmpty
          ? BoxConstraints(minHeight: 200, minWidth: canvasWidth)
          : null,
      child: Column(
        crossAxisAlignment: setting.crossAxisAlignment,
        mainAxisSize: setting.mainAxisSize,
        mainAxisAlignment: setting.mainAxisAlignment,
        children: children.map((c) => c.render()).toList(),
      ),
    );
  }
}
