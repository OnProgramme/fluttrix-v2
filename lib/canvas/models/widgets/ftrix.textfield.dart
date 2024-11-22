import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.textfield.setting.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.textfield.component.dart';

class FTrixTextField extends FTrixDroppableWidgetWithSingleChild {
  @override
  late WidgetType type;

  FTrixTextField({
    super.parentId,
  }) {
    type = WidgetType.INPUT;
    setting = FTrixTextFieldSetting.zero;
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {
    // TODO: implement loadFromJson
  }

  @override
  IWidget clone([String? parentId]) {
    return this;
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
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "setting": setting.toJson(),
      });
  }

  @override
  late FTrixWidgetSetting setting;
}
