import 'package:flutter/material.dart';

class EdgeInsetsSetting {
  double? top;
  double? bottom;
  double? left;
  double? right;

  EdgeInsetsSetting({
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  EdgeInsetsSetting.fromJson(Map<String, dynamic> json) {
    top = json['top'];
    bottom = json['bottom'];
    left = json['left'];
    right = json['right'];
  }

  EdgeInsetsSetting copyWith({
    double? top,
    double? bottom,
    double? left,
    double? right,
  })=> EdgeInsetsSetting(
    top: top ?? this.top,
    bottom: bottom ?? this.bottom,
    left: left ?? this.left,
    right: right ?? this.right,
  );

  Map<String, dynamic> toJson() {
    return {
      'top': top,
      'bottom': bottom,
      'left': left,
      'right': right,
    }..removeWhere((key, value) => value == null);
  }

  bool get isEqual =>
      top == bottom && top == left && top == right && top != null;


}

class BorderRadiusSetting {
  double? topRight;
  double? topLeft;
  double? bottomRight;
  double? bottomLeft;

  BorderRadiusSetting({
    this.topRight,
    this.topLeft,
    this.bottomRight,
    this.bottomLeft,
  });

  BorderRadiusSetting.fromJson(Map<String, dynamic> json) {
    topRight = json['topRight'];
    topLeft = json['topLeft'];
    bottomRight = json['bottomRight'];
    bottomLeft = json['bottomLeft'];
  }

  Map<String, dynamic> toJson() {
    return {
      'topRight': topRight,
      'topLeft': topLeft,
      'bottomRight': bottomRight,
      'bottomLeft': bottomLeft,
    }..removeWhere((key, value) => value == null);
  }

  bool get isEqual =>
      topRight == topLeft &&
      topRight == bottomRight &&
      topRight == bottomLeft &&
      topRight != null;
}

class FTrixWidgetSetting {
  double? height;
  double? width;
  EdgeInsetsSetting padding = EdgeInsetsSetting();
  EdgeInsetsSetting margin = EdgeInsetsSetting();
  BorderRadiusSetting radius = BorderRadiusSetting();

  FTrixWidgetSetting({
    required this.padding,
    required this.margin,
    required this.radius,
    this.width,
    this.height,
  });

  FTrixWidgetSetting.fromJson(Map<String, dynamic> json) {
    padding = json['padding'] != null
        ? EdgeInsetsSetting.fromJson(json['padding'])
        : EdgeInsetsSetting();
    margin = json['margin'] != null
        ? EdgeInsetsSetting.fromJson(json['margin'])
        : EdgeInsetsSetting();
    radius = json['radius'] != null
        ? BorderRadiusSetting.fromJson(json['radius'])
        : BorderRadiusSetting();
    height = json["height"];
    width = json["width"];
  }

  FTrixWidgetSetting.copyWith(FTrixWidgetSetting setting) {
    padding = setting.padding;
    margin = setting.margin;
    radius = setting.radius;
  }

  static FTrixWidgetSetting get zero => FTrixWidgetSetting(
        margin: EdgeInsetsSetting(),
        padding: EdgeInsetsSetting(),
        radius: BorderRadiusSetting(),
      );

  EdgeInsetsGeometry get paddingValue => EdgeInsets.only(
        top: padding.top ?? 0,
        bottom: padding.bottom ?? 0,
        left: padding.left ?? 0,
        right: padding.right ?? 0,
      );

  EdgeInsetsGeometry get marginValue => EdgeInsets.only(
        top: margin.top ?? 0,
        bottom: margin.bottom ?? 0,
        left: margin.left ?? 0,
        right: margin.right ?? 0,
      );

  BorderRadius get radiusValue => BorderRadius.only(
        topLeft: Radius.circular(radius.topLeft ?? 0),
        topRight: Radius.circular(radius.topRight ?? 0),
        bottomLeft: Radius.circular(radius.bottomLeft ?? 0),
        bottomRight: Radius.circular(radius.bottomRight ?? 0),
      );

  Map<String, dynamic> toJson() {
    return {
      'padding': padding.toJson(),
      'margin': margin.toJson(),
      'radius': radius.toJson(),
      "height": height,
      "width": width,
    }..removeWhere((key, value) => value == null);
  }
}
