import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.children.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/drop.position.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.column.row.setting.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.drag.target.dart';

class FTrixColumn extends FTrixWidgetUnScrollChildren {
  @override
  late WidgetType type;

  FTrixColumn({super.parentId}) {
    type = WidgetType.COLUMN;
    streamUpdate.listen(onWidgetUpdate(handleUpdateWidget));
    setting = FTrixColumnRowSetting.zero;
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {}

  @override
  Widget render() {
    final setting = this.setting as FTrixColumnRowSetting;
    return FTrixBaseComponent(
      widget: this,
      onTap: select,
      key: ValueKey(id),
      onDrop: (e)=>handleDropWidget(e),
      child: Column(
        crossAxisAlignment: setting.crossAxisAlignment,
        mainAxisSize: setting.mainAxisSize,
        mainAxisAlignment: setting.mainAxisAlignment,
        children: children.map((c) => c.render()).toList(),
      ),
    );
    return FTrixDragTarget(
      onDrop: (details) => handleDropWidget(
          DroppedWidgetEvent(DropPosition.INSIDE, details.data)),
      child: Container(
        color: Colors.grey[100],
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          key: ValueKey(id),
          children: children.map((c) => c.render()).toList(),
        ),
      ),
    );
  }

  @override
  void handleUpdateWidget(FTrixWidgetEventType type, IWidget widget) {
    // TODO: implement handleUpdateWidget
  }

  @override
  late FTrixWidgetSetting setting;
}
