import 'dart:ui';

import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/utils/parse.interger.to.color.dart';

class FTrixButtonSetting extends FTrixWidgetSetting {
  Color? color;
  Color? textColor;
  Color? borderColor;
  late bool fullWidth;


  FTrixButtonSetting(
      {required super.padding,
      required super.margin,
      required super.radius,
        this.borderColor,
        this.color,
        this.textColor,
        this.fullWidth = false,
      }): super(width: 200, height: 50);

  FTrixButtonSetting.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    color = json["color"] != null ? parseIntegerColor(json["color"]) : null;
    textColor =
    json["textColor"] != null ? parseIntegerColor(json["textColor"]) : null;
    borderColor =
    json["borderColor"] != null ? parseIntegerColor(json["borderColor"]) : null;
    fullWidth = json["fullWidth"] ?? false;
  }

  static FTrixButtonSetting get zero => FTrixButtonSetting(
        padding: FTrixWidgetSetting.zero.padding.copyWith(left: 15, right: 15),
        margin: FTrixWidgetSetting.zero.margin,
        radius: FTrixWidgetSetting.zero.radius,
      );

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "color": color,
        "textColor": textColor,
        "borderColor": borderColor,
        "fullWidth": fullWidth,
    })..removeWhere((key, value) => value == null);
  }
}
