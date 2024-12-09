import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.droppable.widget.without.child.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.image.setting.dart';
import 'package:fluttrix/canvas/models/utils/generate.random.image.dart';
import 'package:fluttrix/canvas/models/utils/normalize.json.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.image.component.dart';

class FTrixImage extends FTrixDroppableWidgetWithoutChild {
  String src;
  FTrixImage({
    this.src = '',
    super.parentId,
    FTrixImageSetting? setting,
  }) : super(
            type: WidgetType.IMAGE,
            setting: setting ?? FTrixImageSetting.zero) {
    src = src.isEmpty ? generateRandomImage() : src;
  }

  @override
  IWidget clone([String? parentId]) {
    return FTrixImage(
      parentId: parentId ?? this.parentId,
      src: src,
      setting: FTrixImageSetting.fromJson(setting.toJson()),
    );
  }

  @override
  Widget render() {
    return FtrixImageComponent(
      onDrop: handleDropWidget,
      widget: this,
      setting: setting as FTrixImageSetting,
      isSelected: isWidgetSelected,
      onTap: select,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "src": src,
      });
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {
    setting = FTrixImageSetting.fromJson(normalizeJson(json['setting']));
  }
}
