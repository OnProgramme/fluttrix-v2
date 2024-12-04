import 'dart:ui';

import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.icon.setting.dart';
import 'package:fluttrix/canvas/models/utils/parse.interger.to.color.dart';

class FTrixIconButtonSetting extends FTrixIconSetting {
  FTrixIconButtonSetting({
    required super.padding,
    required super.margin,
    required super.radius,
    super.color,
  });

  FTrixIconButtonSetting.fromJson(super.json)
      : super.fromJson();

  static FTrixIconButtonSetting get zero => FTrixIconButtonSetting(
        padding: FTrixWidgetSetting.zero.padding.copyWith(left: 15, right: 15),
        margin: FTrixWidgetSetting.zero.margin,
        radius: FTrixWidgetSetting.zero.radius,
      );

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..removeWhere((key, value) => value == null);
  }
}
