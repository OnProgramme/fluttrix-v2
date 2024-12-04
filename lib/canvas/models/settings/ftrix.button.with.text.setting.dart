import 'dart:ui';

import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.button.setting.dart';
import 'package:fluttrix/canvas/models/utils/parse.interger.to.color.dart';

class FTrixButtonWithTextSetting extends FTrixButtonSetting {
  Color? textColor;

  FTrixButtonWithTextSetting({
    required super.padding,
    required super.margin,
    required super.radius,
    super.borderColor,
    super.color,
    this.textColor,
    super.fullWidth = false,
  });

  FTrixButtonWithTextSetting.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    textColor =
        json["textColor"] != null ? parseIntegerColor(json["textColor"]) : null;
  }

  static FTrixButtonWithTextSetting get zero => FTrixButtonWithTextSetting(
        padding: FTrixWidgetSetting.zero.padding.copyWith(left: 30, right: 30),
        margin: FTrixWidgetSetting.zero.margin,
        radius: FTrixWidgetSetting.zero.radius,
      );

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "textColor": textColor,
      })
      ..removeWhere((key, value) => value == null);
  }
}
