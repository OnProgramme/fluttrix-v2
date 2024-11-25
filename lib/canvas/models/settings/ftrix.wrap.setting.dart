import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/presentation/widgets/inputs/input.dropdown.dart';
import 'package:get/get.dart';

class FTrixWrapSetting extends FTrixWidgetSetting {
  late WrapAlignment alignment;
  late WrapAlignment runAlignment;
  late WrapCrossAlignment crossAxisAlignment;
  late double spacing;
  late double runSpacing;
  late Axis direction;
  FTrixWrapSetting({
    required super.padding,
    required super.margin,
    required super.radius,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.spacing = 0.0,
    this.runSpacing = 0.0,
    this.direction = Axis.horizontal,
  });

  FTrixWrapSetting.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    alignment =
        WrapAlignment.values.firstWhere((el) => el.name == json["alignment"]);
    runAlignment = WrapAlignment.values
        .firstWhere((el) => el.name == json["runAlignment"]);
    crossAxisAlignment = WrapCrossAlignment.values
        .firstWhere((el) => el.name == json["crossAxisAlignment"]);
    spacing = json["spacing"] ?? 0.0;
    runSpacing = json["runSpacing"] ?? 0.0;
    alignment = WrapAlignment.values.firstWhere(
        (el) => el.name == json["alignment"],
        orElse: () => WrapAlignment.start);
    direction = Axis.values.firstWhere((el) => el.name == json["direction"],
        orElse: () => Axis.horizontal);
  }

  static FTrixWrapSetting get zero => FTrixWrapSetting(
        padding: FTrixWidgetSetting.zero.padding,
        margin: FTrixWidgetSetting.zero.margin,
        radius: FTrixWidgetSetting.zero.radius,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "alignment": alignment.name,
      "spacing": spacing,
      "crossAxisAlignment": crossAxisAlignment.name,
      "direction": direction.name,
      "runAlignment": runAlignment.name,
      "runSpacing": runSpacing,
      ...super.toJson(),
    }..removeWhere((key, value) => value == null);
  }

  List<InputDropdownItem<MainAxisAlignment>> get mainAxisAlignmentValue =>
      MainAxisAlignment.values
          .map((e) => InputDropdownItem(e.name.capitalizeFirst!, e))
          .toList();
  List<InputDropdownItem<CrossAxisAlignment>> get crossAxisAlignmentValue =>
      CrossAxisAlignment.values
          .map((e) => InputDropdownItem(e.name.capitalizeFirst!, e))
          .toList();
  List<InputDropdownItem<MainAxisSize>> get maxSizeValue => MainAxisSize.values
      .map((e) => InputDropdownItem(e.name.capitalizeFirst!, e))
      .toList();
}
