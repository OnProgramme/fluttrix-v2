import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';

class FTrixTextFieldSetting extends FTrixWidgetSetting {
  String? label;
  String? hint;
  late bool isPassword;
  late bool isUnderlinedBorder;
  FTrixTextFieldSetting({
    required super.padding,
    required super.margin,
    required super.radius,
    this.label,
    this.hint,
    this.isPassword = false,
    this.isUnderlinedBorder = false,
  });

  FTrixTextFieldSetting.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    isPassword = json["isPassword"];
    isUnderlinedBorder = json["isUnderlinedBorder"];
  }

  static FTrixTextFieldSetting get zero => FTrixTextFieldSetting(
        padding: FTrixWidgetSetting.zero.padding,
        margin: FTrixWidgetSetting.zero.margin,
        radius: FTrixWidgetSetting.zero.radius,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "isPassword": isPassword,
      "isUnderlinedBorder": isUnderlinedBorder,
      ...super.toJson(),
    }..removeWhere((key, value) => value == null);
  }
}
