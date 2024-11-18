import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.button.setting.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';

import '../base/i.widget.dart';

class FTrixButton extends FTrixDroppableWidgetWithSingleChild {
  @override
  late WidgetType type;
  String text;
  VoidCallback? onPressed;

  FTrixButton({
    this.text = 'Button',
    this.onPressed,
    super.parentId,
  }) {
    type = WidgetType.BUTTON;
    streamUpdate.listen(onWidgetUpdate(handleUpdateWidget));
    setting = FTrixButtonSetting.zero;
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {
    type = WidgetType.BUTTON;
    text = json["text"];
  }

  @override
  Widget render() {
    final setting = this.setting as FTrixButtonSetting;
    return FTrixBaseComponent(
      widget: this,
      isSelected: isWidgetSelected,
      onDrop: handleDropWidget,
      setting: setting,
      disablePadding: true,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: setting.radiusValue),
        color: setting.style.color ?? Colors.blue,
        padding: setting.paddingValue,
        onPressed: select,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  void handleUpdateWidget(FTrixWidgetEventType type, IWidget widget) {}

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "text": text,
      });
  }

  @override
  late FTrixWidgetSetting setting;
}
