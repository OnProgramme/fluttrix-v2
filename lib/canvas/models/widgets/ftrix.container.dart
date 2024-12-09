import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.child.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.container.setting.dart';
import 'package:fluttrix/canvas/models/utils/normalize.json.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';

class FTrixContainer extends FTrixWidgetWithChild {
  FTrixContainer({
    super.child,
    super.parentId,
    FTrixContainerSetting? setting,
  }) : super(
          type: WidgetType.CONTAINER,
          setting: setting ?? FTrixContainerSetting.zero,
        );

  @override
  IWidget clone([String? parentId]) {
    final cloneWidget = FTrixContainer(
      setting: FTrixContainerSetting.fromJson(setting.toJson()),
      parentId: parentId ?? this.parentId,
    );
    return cloneWidget..child = child?.clone(cloneWidget.id);
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
      // enableResizedChild: true,
      // isDraggable: false,
      child: Container(
        padding: setting.paddingValue,
        width: setting.width,
        height: setting.height,
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

  @override
  void loadFromJson(Map<String, dynamic> json) {
    setting = FTrixContainerSetting.fromJson(normalizeJson(json['setting']));
  }
}
