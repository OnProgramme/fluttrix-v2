import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.droppable.widget.without.child.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.with.icon.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.button.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.icon.setting.dart';
import 'package:fluttrix/canvas/models/utils/normalize.json.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';

import '../base/i.widget.dart';

class FTrixIcon extends FTrixDroppableWidgetWithoutChild
    with FTrixWidgetWithIcon {
  FTrixIcon({
    super.parentId,
    FTrixIconSetting? setting,
  }) : super(
          type: WidgetType.ICON,
          setting: setting ?? FTrixIconSetting.zero,
        );

  @override
  IWidget clone([String? parentId]) {
    return FTrixIcon(
      setting: FTrixIconSetting.fromJson(setting.toJson()),
      parentId: parentId ?? this.parentId,
    )..icon = icon;
  }

  @override
  Widget render() {
    final setting = this.setting as FTrixIconSetting;
    return FTrixBaseComponent(
      widget: this,
      isSelected: isWidgetSelected,
      onDrop: handleDropWidget,
      setting: setting,
      disablePadding: true,
      onTap: select,
      child: Icon(
        color: setting.color,
        icon.iconData,
        size: setting.size,
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "icon": icon.toJson(),
      });
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {
    super.loadFromJson(json);
    setting = FTrixIconSetting.fromJson(normalizeJson(json['setting']));
  }
}
