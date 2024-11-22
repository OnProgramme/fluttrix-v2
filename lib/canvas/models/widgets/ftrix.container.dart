import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.container.setting.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.child.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/f.canvas.controller.dart';
import 'package:get/get.dart';

class FTrixContainer extends FTrixWidgetWithChild {
  @override
  late WidgetType type;
  @override
  IWidget? child;
  @override
  FTrixWidgetSetting setting;

  FTrixContainer({
    this.child,
    super.parentId,
    required this.setting,
  }) : type = WidgetType.CONTAINER;

  @override
  void loadFromJson(Map<String, dynamic> json) {
    type = WidgetType.CONTAINER;
  }

  @override
  IWidget clone([String? parentId]) {
    return FTrixContainer(
      setting: FTrixContainerSetting.fromJson(setting.toJson()),
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
      onTap: select,
      disablePadding: true,
      isDraggable: false,
      child: Container(
        padding: setting.paddingValue,
        decoration: BoxDecoration(
          color: setting.color,
          borderRadius: setting.radiusValue,
          shape: setting.shape,
          image: setting.backgroundImage != null
              ? DecorationImage(image: NetworkImage(setting.backgroundImage!))
              : null,
        ),
        constraints: BoxConstraints(
          minHeight: child == null ? 100 : 0,
        ),
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
