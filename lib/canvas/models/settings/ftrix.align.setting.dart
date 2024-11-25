import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/presentation/widgets/inputs/input.dropdown.dart';

class FTrixAlignmentSetting extends Alignment {
  const FTrixAlignmentSetting(super.x, super.y);
  FTrixAlignmentSetting.fromJson(Map<String, dynamic> json)
      : super(json['x'], json['y']);
  Map<String, dynamic> toJson() => {'x': x, 'y': y};

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Alignment && super.x == other.x && super.y == other.y;
  }

  @override
  int get hashCode {
    return x.hashCode ^ y.hashCode;
  }
}

enum FTrixAlignmentSettingEnum {
  topLeft(FTrixAlignmentSetting(-1.0, -1.0)),
  topCenter(FTrixAlignmentSetting(0.0, -1.0)),
  topRight(FTrixAlignmentSetting(1.0, -1.0)),
  centerLeft(FTrixAlignmentSetting(-1.0, 0.0)),
  center(FTrixAlignmentSetting(0.0, 0.0)),
  centerRight(FTrixAlignmentSetting(1.0, 0.0)),
  bottomLeft(FTrixAlignmentSetting(-1.0, 1.0)),
  bottomCenter(FTrixAlignmentSetting(0.0, 1.0)),
  bottomRight(FTrixAlignmentSetting(1.0, 1.0));

  final FTrixAlignmentSetting setting;
  const FTrixAlignmentSettingEnum(this.setting);
}

class FTrixAlignSetting extends FTrixWidgetSetting {
  late FTrixAlignmentSetting alignment;
  FTrixAlignSetting(
      {required super.margin,
      required super.padding,
      required super.radius,
      required this.alignment}) {
    alignment = FTrixAlignmentSettingEnum.center.setting;
  }

  static FTrixAlignSetting get zero => FTrixAlignSetting(
        margin: FTrixWidgetSetting.zero.margin,
        padding: FTrixWidgetSetting.zero.padding.copyWith(),
        radius: FTrixWidgetSetting.zero.radius,
        alignment: FTrixAlignmentSettingEnum.center.setting,
      );

  factory FTrixAlignSetting.fromJson(Map<String, dynamic> json) {
    return FTrixAlignSetting(
      margin: EdgeInsetsSetting.fromJson(json['margin']),
      padding: EdgeInsetsSetting.fromJson(json['margin']),
      radius: BorderRadiusSetting.fromJson(json['radius']),
      alignment: json['alignment'] == null
          ? FTrixAlignmentSettingEnum.center.setting
          : FTrixAlignmentSetting.fromJson(json['alignment']),
    );
  }
}
