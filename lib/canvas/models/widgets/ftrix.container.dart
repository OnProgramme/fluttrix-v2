import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.container.setting.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.child.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/utils/normalizeJson.dart';
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
      // isDraggable: false,
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

  @override
  void loadFromJson(Map<String, dynamic> json) {
    setting = FTrixContainerSetting.fromJson(normalizeJson(json['setting']));
  }
}
