import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/utils/generate.random.image.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.image.component.dart';


class FTrixImage extends FTrixDroppableWidgetWithSingleChild  {
  @override
  late WidgetType type;
  String src;

  FTrixImage({this.src = '', super.parentId}) {
    type = WidgetType.IMAGE;
    src = src.isEmpty ? generateRandomImage() : src;
    setting = FTrixWidgetSetting.zero;
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {
    type = WidgetType.IMAGE;
    src = json["src"];
  }

  @override
  Widget render() {
    return FtrixImageComponent(
      onDrop: handleDropWidget,
      widget: this,
      src: src,
      setting: setting,
      isSelected: isWidgetSelected,
      onTap: select,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "src": src,
        "setting": setting.toJson(),
      });
  }

  @override
  late FTrixWidgetSetting setting;
}
