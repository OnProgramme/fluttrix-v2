import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';

class FTrixListViewSetting extends FTrixWidgetSetting {
  late Axis scrollDirection;
  FTrixListViewSetting({
    required super.padding,
    required super.margin,
    required super.radius,
    this.scrollDirection = Axis.vertical,
  });

  FTrixListViewSetting.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    scrollDirection =
        Axis.values.firstWhere((el) => el.name == json["scrollDirection"]);
  }

  static FTrixListViewSetting get zero => FTrixListViewSetting(
        padding: FTrixWidgetSetting.zero.padding,
        margin: FTrixWidgetSetting.zero.margin,
        radius: FTrixWidgetSetting.zero.radius,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "scrollDirection": scrollDirection.name,
      ...super.toJson(),
    }..removeWhere((key, value) => value == null);
  }
}
