import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/utils/parse.interger.to.color.dart';

class FTrixScaffoldSetting extends FTrixWidgetSetting {
  late Color backgroundColor;
  late bool showAppbar;
  late bool showBottomNavBar;
  FTrixScaffoldSetting({
    required super.padding,
    required super.margin,
    required super.radius,
    this.backgroundColor = Colors.white,
    this.showAppbar = true,
    this.showBottomNavBar = false,
  });

  FTrixScaffoldSetting.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    backgroundColor = json['backgroundColor'] != null
        ? parseIntegerColor(json['backgroundColor'])
        : Colors.white;
    showAppbar = json['showAppbar'] ?? false;
    showBottomNavBar = json['showBottomNavBar'] ?? false;
  }

  static FTrixScaffoldSetting get zero => FTrixScaffoldSetting(
        padding: FTrixWidgetSetting.zero.padding,
        margin: FTrixWidgetSetting.zero.margin,
        radius: FTrixWidgetSetting.zero.radius,
      );

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "backgroundColor": backgroundColor.value,
        "showAppbar": showAppbar,
        "showBottomNavBar": showBottomNavBar,
      })
      ..removeWhere((key, value) => value == null);
  }
}
