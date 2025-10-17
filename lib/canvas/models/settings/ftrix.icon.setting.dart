import 'dart:ui';

import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/utils/parse.interger.to.color.dart';

class FTrixIconSetting extends FTrixWidgetSetting {
  Color? color;
  double? size;

  FTrixIconSetting({
    required super.padding,
    required super.margin,
    required super.radius,
    this.color,
    this.size,
  }) : super(width: 200, height: 50);

  FTrixIconSetting.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    color = json["color"] != null ? parseIntegerColor(json["color"]) : null;
    size = json['size'];
  }

  static FTrixIconSetting get zero => FTrixIconSetting(
    padding: FTrixWidgetSetting.zero.padding.copyWith(left: 15, right: 15),
    margin: FTrixWidgetSetting.zero.margin,
    radius: FTrixWidgetSetting.zero.radius,
  );

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "color": color?.value,
        "size": size,
      })
      ..removeWhere((key, value) => value == null);
  }
}
