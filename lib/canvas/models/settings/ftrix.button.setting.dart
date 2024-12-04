import 'dart:ui';

import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/utils/parse.interger.to.color.dart';

class FTrixButtonSetting extends FTrixWidgetSetting {
  Color? color;
  Color? borderColor;
  late bool fullWidth;


  FTrixButtonSetting(
      {required super.padding,
      required super.margin,
      required super.radius,
        this.borderColor,
        this.color,
        this.fullWidth = false,
      }): super(height: 50);

  FTrixButtonSetting.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    color = json["color"] != null ? parseIntegerColor(json["color"]) : null;
    borderColor =
    json["borderColor"] != null ? parseIntegerColor(json["borderColor"]) : null;
    fullWidth = json["fullWidth"] ?? false;
  }

  static FTrixButtonSetting get zero => FTrixButtonSetting(
        padding: FTrixWidgetSetting.zero.padding.copyWith(left: 30, right: 30),
        margin: FTrixWidgetSetting.zero.margin,
        radius: FTrixWidgetSetting.zero.radius,
      );

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "color": color,
        "borderColor": borderColor,
        "fullWidth": fullWidth,
    })..removeWhere((key, value) => value == null);
  }
}
