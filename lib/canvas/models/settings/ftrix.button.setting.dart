import 'dart:ui';

import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/utils/parse.interger.to.color.dart';

class FTrixButtonStyle {
  Color? color;
  Color? textColor;
  double? height;
  double? width;
  FTrixButtonStyle({
    this.color,
    this.textColor,
    this.height,
    this.width,
  });

  FTrixButtonStyle.fromJson(Map<String, dynamic> json) {
    color = json["color"] != null ? parseIntegerColor(json["color"]) : null;
    textColor =
        json["textColor"] != null ? parseIntegerColor(json["textColor"]) : null;
    height = json["height"];
    width = json["width"];
  }

  Map<String, dynamic> toJson() {
    return {
      "color": color,
      "textColor": textColor,
      "height": height,
      "width": width,
    }..removeWhere((key, value) => value == null);
  }
}

class FTrixButtonSetting extends FTrixWidgetSetting {
  late FTrixButtonStyle style;
  FTrixButtonSetting(
      {required super.padding,
      required super.margin,
      required super.radius,
      required this.style});

  FTrixButtonSetting.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    style = FTrixButtonStyle.fromJson(json["style"]);
  }

  static FTrixButtonSetting get zero => FTrixButtonSetting(
        padding: FTrixWidgetSetting.zero.padding,
        margin: FTrixWidgetSetting.zero.margin,
        radius: FTrixWidgetSetting.zero.radius,
        style: FTrixButtonStyle(),
      );

  @override
  Map<String, dynamic> toJson() {
    final styleMap = style.toJson();
    return {
      "style": styleMap.isNotEmpty ? styleMap : null,
      ...super.toJson(),
    }..removeWhere((key, value) => value == null);
  }
}
