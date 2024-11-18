import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/utils/parse.interger.to.color.dart';

class FTrixColumnRowSetting extends FTrixWidgetSetting {
  late MainAxisAlignment mainAxisAlignment;
  late CrossAxisAlignment crossAxisAlignment;
  late MainAxisSize mainAxisSize;
  FTrixColumnRowSetting({
    required super.padding,
    required super.margin,
    required super.radius,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
  });

  FTrixColumnRowSetting.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    mainAxisAlignment = MainAxisAlignment.values
        .firstWhere((el) => el.name == json["mainAxisAlignment"]);
    crossAxisAlignment = CrossAxisAlignment.values
        .firstWhere((el) => el.name == json["crossAxisAlignment"]);
    mainAxisSize = MainAxisSize.values
        .firstWhere((el) => el.name == json["mainAxisSize"]);
  }

  static FTrixColumnRowSetting get zero => FTrixColumnRowSetting(
        padding: FTrixWidgetSetting.zero.padding,
        margin: FTrixWidgetSetting.zero.margin,
        radius: FTrixWidgetSetting.zero.radius,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "mainAxisAlignment": mainAxisAlignment.name,
      "crossAxisAlignment": crossAxisAlignment.name,
      "mainAxisSize": mainAxisSize.name,
      ...super.toJson(),
    }..removeWhere((key, value) => value == null);
  }
}
