import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';

class FTrixImageSetting extends FTrixWidgetSetting {
  late bool fullWidth;

  FTrixImageSetting({
    required super.padding,
    required super.margin,
    required super.radius,
    super.height,
    super.width,
    this.fullWidth = false,
  });

  FTrixImageSetting.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    fullWidth = json["fullWidth"] ?? false;
    height = json["height"] ?? 300;
  }

  static FTrixImageSetting get zero => FTrixImageSetting(
        padding: FTrixWidgetSetting.zero.padding,
        margin: FTrixWidgetSetting.zero.margin,
        radius: FTrixWidgetSetting.zero.radius,
        fullWidth: true,
        height: 300,
      );

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "fullWidth": fullWidth,
      })
      ..removeWhere((key, value) => value == null);
  }
}
