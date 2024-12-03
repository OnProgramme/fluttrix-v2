import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.droppable.widget.without.child.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.button.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.icon.button.setting.dart';
import 'package:fluttrix/canvas/models/utils/normalizeJson.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';

import '../base/i.widget.dart';

class CustomIcon {
  int icon;
  String iconName;
  CustomIcon(this.icon, this.iconName);

  factory CustomIcon.fromJson(Map<String, dynamic> json) =>
      CustomIcon(json['icon'] ?? json['code'], json['iconName'] ?? json['css']);

  Map<String, dynamic> toJson() => {"icon": icon, "iconName": iconName};

  IconData get iconData => IconData(icon, fontFamily: "materialIcons");
}

class FTrixIconButton extends FTrixDroppableWidgetWithoutChild {
  late CustomIcon icon;

  FTrixIconButton({
    super.parentId,
    FTrixIconButtonSetting? setting,
  })  : icon = CustomIcon(60582, 'arrow_back'),
        super(
            type: WidgetType.ICON_BUTTON,
            setting: setting ?? FTrixIconButtonSetting.zero);

  @override
  IWidget clone([String? parentId]) {
    return FTrixIconButton(
      setting: FTrixIconButtonSetting.fromJson(setting.toJson()),
      parentId: parentId ?? this.parentId,
    )..icon = icon;
  }

  @override
  Widget render() {
    final setting = this.setting as FTrixIconButtonSetting;
    return FTrixBaseComponent(
      widget: this,
      isSelected: isWidgetSelected,
      onDrop: handleDropWidget,
      setting: setting,
      disablePadding: true,
      child: IconButton(
          onPressed: select,
          icon: Icon(
            color: setting.color,
            icon.iconData,
          )),
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
