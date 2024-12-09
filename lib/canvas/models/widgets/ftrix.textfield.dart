import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.droppable.widget.without.child.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.textfield.setting.dart';
import 'package:fluttrix/canvas/models/utils/normalize.json.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.textfield.component.dart';

class FTrixTextField extends FTrixDroppableWidgetWithoutChild {
  FTrixTextField({
    super.parentId,
    FTrixTextFieldSetting? setting,
  }) : super(
            type: WidgetType.INPUT,
            setting: setting ?? FTrixTextFieldSetting.zero);

  @override
  IWidget clone([String? parentId]) {
    return FTrixTextField(
      setting: FTrixTextFieldSetting.fromJson(setting.toJson()),
      parentId: parentId ?? this.parentId,
    );
  }

  @override
  Widget render() {
    final setting = this.setting as FTrixTextFieldSetting;
    return FtrixTextFieldComponent(
      setting: setting,
      widget: this,
      onTap: select,
      isSelected: isWidgetSelected,
      onDrop: handleDropWidget,
    );
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {
    setting = FTrixTextFieldSetting.fromJson(normalizeJson(json['setting']));
  }
}
