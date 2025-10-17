import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/utils/parse.interger.to.color.dart';

class FTrixAppBarSetting extends FTrixWidgetSetting {
  bool centerTitle;
  Color? backgroundColor;
  FTrixAppBarSetting({
    required super.margin,
    required super.padding,
    required super.radius,
    this.centerTitle = true,
    this.backgroundColor = Colors.blue,
  });

  factory FTrixAppBarSetting.fromJson(Map<String, dynamic> json) =>
      FTrixAppBarSetting(
        margin: EdgeInsetsSetting.fromJson(json['margin']),
        padding: EdgeInsetsSetting.fromJson(json['margin']),
        radius: BorderRadiusSetting.fromJson(json['radius']),
        centerTitle: json['centerTitle'] ?? true,
        backgroundColor: parseIntegerColor(json['backgroundColor']),
      );

  static FTrixAppBarSetting get zero => FTrixAppBarSetting(
        padding: FTrixWidgetSetting.zero.padding,
        margin: FTrixWidgetSetting.zero.margin,
        radius: FTrixWidgetSetting.zero.radius,
      );

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        'centerTitle': centerTitle,
        'backgroundColor': backgroundColor?.value,
      });
  }
}
