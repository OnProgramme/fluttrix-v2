import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.children.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.column.row.setting.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';
import 'package:get/get.dart';

class FTrixRow extends FTrixWidgetUnScrollChildren {
  @override
  late WidgetType type;

  FTrixRow({super.parentId, required this.setting}) {
    type = WidgetType.ROW;
    streamUpdate.listen(onWidgetUpdate(handleUpdateWidget));
  }

  @override
  IWidget clone([String? parentId]) {
    return this;
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

  @override
  late FTrixWidgetSetting setting;
}
