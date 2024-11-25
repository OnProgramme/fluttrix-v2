import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.droppable.widget.without.child.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.rich.text.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.text.setting.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';

import '../enums/widget.type.dart';

class FTrixRichText extends FTrixDroppableWidgetWithoutChild {
  late List<FTrixRichTextSetting> text;
  int? maxLines;

  FTrixRichText({
    this.maxLines,
    super.parentId,
    FTrixTextSetting? setting,
  }) : super(
            type: WidgetType.RICH_TEXT,
            setting: setting ?? FTrixTextSetting.zero) {
    final settingText = this.setting as FTrixTextSetting;
    text = [
      FTrixRichTextSetting(
          text: "Hello ",
          setting: FTrixTextSetting.fromJson(settingText.toJson()),
          index: 0),
      FTrixRichTextSetting(
          text: "World",
          setting: FTrixTextSetting.fromJson(settingText.toJson())
            ..color = Colors.blue,
          index: 1),
    ];
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {
    text = json['text'];
    maxLines = json['maxLines'];
  }

  @override
  IWidget clone([String? parentId]) {
    return this;
  }

  void addText() {
    text.add(FTrixRichTextSetting.empty.copyWith(index: text.length));
    update();
  }

  void deleteText(int index) {
    text.removeAt(index);
    for (var i = index; i < text.length; i++) {
      text[i].index = index;
    }
    update();
  }

  @override
  Widget render() {
    final setting = this.setting as FTrixTextSetting;
    return FTrixBaseComponent(
      widget: this,
      isSelected: isWidgetSelected,
      setting: setting,
      onTap: select,
      child: Text.rich(
        TextSpan(
          children: text
              .map((e) => TextSpan(
                    text: e.text,
                    style: TextStyle(
                      decoration: e.setting.decorationValue,
                      fontSize: e.setting.fontSize,
                      color: e.setting.color,
                      fontWeight: e.setting.fontWeightValue,
                    ),
                  ))
              .toList(),
        ),
        maxLines: setting.maxLines,
        textAlign: setting.textAlign,
        style: TextStyle(
          decoration: setting.decorationValue,
          fontSize: setting.fontSize,
          color: setting.color,
          fontWeight: setting.fontWeightValue,
        ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "text": text.map((e) => e.toJson()).toList(),
      });
  }
}
