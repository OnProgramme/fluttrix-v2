import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.align.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.container.setting.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.child.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/f.canvas.controller.dart';
import 'package:get/get.dart';

class FTrixAlign extends FTrixWidgetWithChild {
  FTrixAlign({
    super.child,
    super.parentId,
    FTrixAlignSetting? setting,
  }) : super(
          type: WidgetType.ALIGN,
          setting: setting ?? FTrixAlignSetting.zero,
        );

  @override
  void loadFromJson(Map<String, dynamic> json) {
    type = WidgetType.ALIGN;
  }

  @override
  IWidget clone([String? parentId]) {
    return FTrixAlign(
      setting: FTrixAlignSetting.fromJson(setting.toJson()),
      parentId: parentId,
      child: child,
    );
  }

  @override
  Widget render() {
    final setting = this.setting as FTrixAlignSetting;
    return FTrixBaseComponent(
      onDrop: handleDropWidget,
      widget: this,
      setting: setting,
      isSelected: isWidgetSelected,
      onTap: select,
      disablePadding: true,
      isDraggable: false,
      constraints: child == null ? BoxConstraints(minHeight: 100) : null,
      child: Align(
        alignment: setting.alignment ?? Alignment.center,
        child: child?.render(),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "child": child?.toJson(),
        "setting": setting.toJson(),
      });
  }
}
