import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';

class FTrixContainerSetting extends FTrixWidgetSetting {
  Color? color;
  BoxShape shape;
  String? backgroundImage;

  FTrixContainerSetting({
    required super.margin,
    required super.padding,
    required super.radius,
    this.shape = BoxShape.rectangle,
    super.height,
    super.width,
    this.color,
    this.backgroundImage,
  });

  static FTrixContainerSetting get zero => FTrixContainerSetting(
        margin: FTrixWidgetSetting.zero.margin,
        padding: FTrixWidgetSetting.zero.padding,
        radius: FTrixWidgetSetting.zero.radius,
      );

  factory FTrixContainerSetting.fromJson(Map<String, dynamic> json) {
    return FTrixContainerSetting(
      margin: EdgeInsetsSetting.fromJson(json['margin']),
      padding: EdgeInsetsSetting.fromJson(json['margin']),
      radius: BorderRadiusSetting.fromJson(json['radius']),
      color: json['color'],
      width: json['width'],
      height: json['height'],
      shape: BoxShape.values.firstWhere((el) => el.name == json['shape'], orElse: () => BoxShape.rectangle),
      backgroundImage: json['backgroundImage'],
    );
  }
}