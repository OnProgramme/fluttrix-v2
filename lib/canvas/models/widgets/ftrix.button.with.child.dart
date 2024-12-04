import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.button.dart';
import 'package:fluttrix/canvas/models/base/ftrix.droppable.widget.without.child.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.child.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.button.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.column.row.setting.dart';
import 'package:fluttrix/canvas/models/utils/normalizeJson.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.icon.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.row.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.text.dart';

import '../base/i.widget.dart';

class FTrixButtonWithChild extends FTrixWidgetWithChild with FTrixButton{
  FTrixButtonWithChild({
    super.parentId,
    super.child,
    FTrixButtonSetting? setting,
  }) : super(
          type: WidgetType.BUTTON_WITH_CHILD,
          setting: setting ?? FTrixButtonSetting.zero,
        ){
    child ??= FTrixRow(
      setting: FTrixColumnRowSetting.zero..mainAxisSize = MainAxisSize.min,
      children: [
        FTrixIcon(),
        FTrixText(text: "Bouton"),
      ]
    );
  }

  @override
  IWidget clone([String? parentId]) {
    return FTrixButtonWithChild(
      setting: FTrixButtonSetting.fromJson(setting.toJson()),
      parentId: parentId ?? this.parentId,
      child: child,
    );
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
      child: SizedBox(
        width: setting.fullWidth ? double.infinity : setting.width,
        child: MaterialButton(
          height: setting.height,
          shape: RoundedRectangleBorder(
            borderRadius: setting.radiusValue,
            side: BorderSide(
              color: setting.borderColor ?? setting.color ?? Colors.blue,
            ),
          ),
          color: setting.color ?? Colors.blue,
          padding: setting.paddingValue,
          onPressed: select,
          child: child?.render(),
        ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson();
  }


  @override
  void loadFromJson(Map<String, dynamic> json) {
    setting = FTrixButtonSetting.fromJson(normalizeJson(json['setting']));
  }
}
