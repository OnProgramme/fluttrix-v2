import 'dart:ui';

import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/utils/parse.interger.to.color.dart';
import 'package:fluttrix/presentation/widgets/inputs/input.dropdown.dart';
import 'package:get/get.dart';

enum TextDecorationEnum { none, underline, overline, lineThrough }

enum FontWeightEnum { w100, w200, w300, w400, w500, w600, w700, w800, w900 }

class FTrixTextSetting extends FTrixWidgetSetting {
  Color? color;
  double? fontSize;
  TextDecorationEnum? decoration;
  FontWeightEnum? fontWeight;
  late TextAlign textAlign;
  int? maxLines;

  FTrixTextSetting({
    required super.padding,
    required super.margin,
    required super.radius,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeightEnum.w400,
    this.color,
    this.fontSize,
    this.decoration,
    this.maxLines,
  });

  FTrixTextSetting.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    textAlign = TextAlign.values.firstWhere(
        (el) => el.name == json['textAlign'],
        orElse: () => TextAlign.start);
    color = json['color'] != null ? parseIntegerColor(json['color']) : null;
    fontSize = json['fontSize'];
    decoration = json['decoration'] == null
        ? null
        : TextDecorationEnum.values.firstWhere(
            (el) => el.name == json['decoration'],
            orElse: () => TextDecorationEnum.none);
    fontWeight = FontWeightEnum.values.firstWhere(
        (el) => el.name == json['fontWeight'],
        orElse: () => FontWeightEnum.w400);
  }

  static FTrixTextSetting get zero => FTrixTextSetting(
        padding: FTrixWidgetSetting.zero.padding,
        margin: FTrixWidgetSetting.zero.margin,
        radius: FTrixWidgetSetting.zero.radius,
      );

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "textAlign": textAlign.name,
        "color": color?.value,
        "fontSize": fontSize,
        "decoration": decoration?.name,
        "fontWeight": fontWeight?.name,
      })
      ..removeWhere((key, value) => value == null);
  }

  List<InputDropdownItem<TextAlign>> get textAlignValue => TextAlign.values
      .map((e) => InputDropdownItem(e.name.capitalizeFirst!, e))
      .toList();

  List<InputDropdownItem<TextDecorationEnum>> get textDecorationValues =>
      TextDecorationEnum.values
          .map((e) => InputDropdownItem(e.name.capitalizeFirst!, e))
          .toList();

  List<InputDropdownItem<FontWeightEnum>> get fontWeightValues =>
      FontWeightEnum.values
          .map((e) => InputDropdownItem(e.name.capitalizeFirst!, e))
          .toList();

  TextDecoration? get decorationValue {
    switch (decoration) {
      case TextDecorationEnum.none:
        return TextDecoration.none;
      case TextDecorationEnum.underline:
        return TextDecoration.underline;
      case TextDecorationEnum.overline:
        return TextDecoration.overline;
      case TextDecorationEnum.lineThrough:
        return TextDecoration.lineThrough;
      default:
        return null;
    }
  }

  FontWeight get fontWeightValue {
    switch (fontWeight) {
      case FontWeightEnum.w100:
        return FontWeight.w100;
      case FontWeightEnum.w200:
        return FontWeight.w200;
      case FontWeightEnum.w300:
        return FontWeight.w300;
      case FontWeightEnum.w400:
        return FontWeight.w400;
      case FontWeightEnum.w500:
        return FontWeight.w500;
      case FontWeightEnum.w600:
        return FontWeight.w600;
      case FontWeightEnum.w700:
        return FontWeight.w700;
      case FontWeightEnum.w800:
        return FontWeight.w800;
      case FontWeightEnum.w900:
        return FontWeight.w900;
      default:
        return FontWeight.w400;
    }
  }
}
