import 'dart:ui';

import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/utils/parse.interger.to.color.dart';

class FTrixImageSetting extends FTrixWidgetSetting {
  late bool fullWidth;


  FTrixImageSetting(
      {required super.padding,
      required super.margin,
      required super.radius,
        this.fullWidth = false,
      });

  FTrixImageSetting.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    fullWidth = json["fullWidth"] ?? false;
  }

  static FTrixImageSetting get zero => FTrixImageSetting(
        padding: FTrixWidgetSetting.zero.padding,
        margin: FTrixWidgetSetting.zero.margin,
        radius: FTrixWidgetSetting.zero.radius,
      );

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "fullWidth": fullWidth,
    })..removeWhere((key, value) => value == null);
  }
}
