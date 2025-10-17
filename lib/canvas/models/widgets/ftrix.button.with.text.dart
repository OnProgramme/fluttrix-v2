import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.button.dart';
import 'package:fluttrix/canvas/models/base/ftrix.droppable.widget.without.child.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.button.with.text.setting.dart';
import 'package:fluttrix/canvas/models/utils/normalize.json.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';

import '../base/i.widget.dart';

class FTrixButtonWithText extends FTrixDroppableWidgetWithoutChild with FTrixButton{
  String text;

  FTrixButtonWithText({
    this.text = 'Button',
    super.parentId,
    FTrixButtonWithTextSetting? setting,
  }) : super(
          type: WidgetType.BUTTON,
          setting: setting ?? FTrixButtonWithTextSetting.zero,
        );

  @override
  IWidget clone([String? parentId]) {
    return FTrixButtonWithText(
      setting: FTrixButtonWithTextSetting.fromJson(setting.toJson()),
      text: text,
      parentId: parentId ?? this.parentId,
    );
  }

  @override
  Widget render() {
    final setting = this.setting as FTrixButtonWithTextSetting;
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
  void loadFromJson(Map<String, dynamic> json) {
    text = json['text'];
    print(json['setting']);
    setting = FTrixButtonWithTextSetting.fromJson(normalizeJson(json['setting']));
  }
}
