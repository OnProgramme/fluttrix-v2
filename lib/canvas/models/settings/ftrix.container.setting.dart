import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.align.setting.dart';

class FTrixContainerSetting extends FTrixAlignSetting {
  Color? color;
  BoxShape shape;
  String? backgroundImage;

  FTrixContainerSetting(
      {required super.margin,
      required super.padding,
      required super.radius,
      this.shape = BoxShape.rectangle,
      this.color,
      this.backgroundImage,
      double? width,
      double? height})
      : super(alignment: FTrixAlignmentSettingEnum.topLeft.setting) {
    this.width = width;
    this.height = height;
  }

  static FTrixContainerSetting get zero => FTrixContainerSetting(
        margin: FTrixWidgetSetting.zero.margin,
        padding: FTrixWidgetSetting.zero.padding.copyWith(),
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
      shape: BoxShape.values.firstWhere((el) => el.name == json['shape'],
          orElse: () => BoxShape.rectangle),
      backgroundImage: json['backgroundImage'],
    );
  }
}
