import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.container.setting.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.child.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/f.canvas.controller.dart';
import 'package:get/get.dart';

class FTrixCenter extends FTrixWidgetWithChild {
  FTrixCenter({
    super.parentId,
    super.child,
  }) : super(
          type: WidgetType.CENTER,
          setting: FTrixWidgetSetting.zero,
        );

  @override
  void loadFromJson(Map<String, dynamic> json) {
    type = WidgetType.CENTER;
  }

  @override
  IWidget clone([String? parentId]) {
    return FTrixCenter(
      parentId: parentId,
      child: child,
    );
  }

  @override
  Widget render() {
    final setting = this.setting as FTrixContainerSetting;
    return FTrixBaseComponent(
      onDrop: handleDropWidget,
      widget: this,
      setting: setting,
      isSelected: isWidgetSelected,
      constraints: child == null ? BoxConstraints(minHeight: 100) : null,
      onTap: select,
      disablePadding: true,
      isDraggable: false,
      child: Center(
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
