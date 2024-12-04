import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.children.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.column.row.setting.dart';
import 'package:fluttrix/canvas/models/utils/normalizeJson.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';

class FTrixRow extends FTrixWidgetWithChildren {
  FTrixRow(
      {super.parentId,
      FTrixColumnRowSetting? setting,
      super.children = const []})
      : super(
            type: WidgetType.ROW,
            setting: setting ?? FTrixColumnRowSetting.zero);

  @override
  IWidget clone([String? parentId]) {
    final cloneWidget = FTrixRow(
      parentId: parentId ?? this.parentId,
      setting: FTrixColumnRowSetting.fromJson(setting.toJson()),
    );
    cloneWidget.children =
        children.map((el) => el.clone(cloneWidget.id)).toList();
    return cloneWidget;
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {
    setting = FTrixColumnRowSetting.fromJson(normalizeJson(json['setting']));
  }

  @override
  Widget render() {
    final setting = this.setting as FTrixColumnRowSetting;
    return FTrixBaseComponent(
      setting: setting,
      isSelected: isWidgetSelected,
      widget: this,
      onTap: select,
      key: ValueKey(id),
      onDrop: (e) => handleDropWidget(e),
      constraints: children.isEmpty ? BoxConstraints(minHeight: 100) : null,
      child: Row(
        crossAxisAlignment: setting.crossAxisAlignment,
        mainAxisSize: setting.mainAxisSize,
        mainAxisAlignment: setting.mainAxisAlignment,
        children: children.map((c) => c.render()).toList(),
      ),
    );
  }
}
