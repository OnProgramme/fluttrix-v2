import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.button.setting.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';

import '../base/i.widget.dart';

class FTrixButton extends FTrixDroppableWidgetWithSingleChild {
  @override
  late WidgetType type;
  String text;

  FTrixButton({
    this.text = 'Button',
    super.parentId,
    required this.setting,
  }) : type = WidgetType.BUTTON;

  @override
  void loadFromJson(Map<String, dynamic> json) {
    type = WidgetType.BUTTON;
    text = json["text"];
  }

  @override
  IWidget clone([String? parentId]) {
    return FTrixButton(
      setting: FTrixButtonSetting.fromJson(setting.toJson()),
      text: text,
      parentId: parentId ?? this.parentId,
    );
  }

  @override
  Widget render() {
    final setting = this.setting as FTrixButtonSetting;

    return FTrixBaseComponent(
      widget: this,
      isSelected: isWidgetSelected,
      onDrop: handleDropWidget,
      setting: setting,
      disablePadding: true,
      child: SizedBox(
        width: setting.fullWidth ? double.infinity : setting.width,
        child: MaterialButton(
          height: setting.height,
          shape: RoundedRectangleBorder(
            borderRadius: setting.radiusValue,
            side: BorderSide(
              color: setting.borderColor ?? setting.color ?? Colors.blue,
            ),
          ),
          color: setting.color ?? Colors.blue,
          padding: setting.paddingValue,
          onPressed: select,
          child: Text(
            text,
            style: TextStyle(
              color: setting.textColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "text": text,
      });
  }

  @override
  late FTrixWidgetSetting setting;
}
