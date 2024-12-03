import 'dart:ui';

import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/utils/parse.interger.to.color.dart';

class FTrixIconButtonSetting extends FTrixWidgetSetting {
  Color? color;

  FTrixIconButtonSetting({
    required super.padding,
    required super.margin,
    required super.radius,
    this.color,
  }) : super(width: 200, height: 50);

  FTrixIconButtonSetting.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    color = json["color"] != null ? parseIntegerColor(json["color"]) : null;
  }

  static FTrixIconButtonSetting get zero => FTrixIconButtonSetting(
        padding: FTrixWidgetSetting.zero.padding.copyWith(left: 15, right: 15),
        margin: FTrixWidgetSetting.zero.margin,
        radius: FTrixWidgetSetting.zero.radius,
      );

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "color": color,
      })
      ..removeWhere((key, value) => value == null);
  }
}
