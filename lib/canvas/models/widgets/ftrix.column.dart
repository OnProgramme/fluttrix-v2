import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.children.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.drag.target.dart';

class FTrixColumn extends FTrixWidgetUnScrollChildren {
  @override
  late WidgetType type;

  FTrixColumn() {
    type = WidgetType.COLUMN;
    streamUpdate.listen(onWidgetUpdate(handleUpdateWidget));
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {}

  @override
  Widget render() {
    return FTrixDragTarget(
      onDrop: handleDropWidget,
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
  void handleUpdateWidget(IWidget widget) {
    // TODO: implement handleUpdateWidget
  }
}
