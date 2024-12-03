import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.droppable.widget.without.child.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.button.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.icon.button.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.icon.setting.dart';
import 'package:fluttrix/canvas/models/utils/normalizeJson.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.icon.button.dart';

import '../base/i.widget.dart';

class FTrixIcon extends FTrixDroppableWidgetWithoutChild {
  late CustomIcon icon;

  FTrixIcon({
    super.parentId,
    FTrixIconSetting? setting,
  })  : icon = CustomIcon(60582, 'arrow_back'),
        super(
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
    icon = CustomIcon.fromJson(json['icon']);
    setting = FTrixButtonSetting.fromJson(normalizeJson(json['setting']));
  }
}
