import 'package:flutter/cupertino.dart';
import 'package:fluttrix/canvas/models/base/ftrix.droppable.widget.without.child.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.text.setting.dart';
import 'package:fluttrix/canvas/models/utils/normalize.json.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';

import '../enums/widget.type.dart';

class FTrixText extends FTrixDroppableWidgetWithoutChild {
  String text;

  FTrixText({
    this.text = "Hello Word",
    super.parentId,
    FTrixTextSetting? setting,
  }) : super(type: WidgetType.TEXT, setting: setting ?? FTrixTextSetting.zero);

  @override
  void loadFromJson(Map<String, dynamic> json) {
    super.loadFromJson(json);
    text = json['text'];
    setting = FTrixTextSetting.fromJson(normalizeJson(json['setting']));
  }

  @override
  IWidget clone([String? parentId]) {
    return FTrixText(
      parentId: parentId ?? this.parentId,
      setting: FTrixTextSetting.fromJson(setting.toJson()),
      text: text,
    );
  }

  @override
  Widget render() {
    final setting = this.setting as FTrixTextSetting;
    return FTrixBaseComponent(
      widget: this,
      isSelected: isWidgetSelected,
      setting: setting,
      onTap: select,
      child: Text(
        text,
        style: TextStyle(
          decoration: setting.decorationValue,
          fontSize: setting.fontSize,
          color: setting.color,
          fontWeight: setting.fontWeightValue,
        ),
        maxLines: setting.maxLines,
        textAlign: setting.textAlign,
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "text": text,
      });
  }
}
