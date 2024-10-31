import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.children.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.drag.target.dart';

class FTrixListView extends FTrixWidgetChildren {

  @override
  late WidgetType type;

  FTrixListView(){
    type = WidgetType.LISTVIEW;
    streamUpdate.listen(onWidgetUpdate(handleUpdateWidget));
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {
    // TODO: implement loadFromJson
  }

  @override
  Widget render() {
    return FTrixDragTarget(
      onDrop: handleDropWidget,
      child: ListView(
        padding: EdgeInsets.all(15),
        key: ValueKey(id),
        children: children.map((c)=>c.render()).toList(),
      ),
    );
  }

  @override
  void handleUpdateWidget(IWidget widget) {
    // TODO: implement handleUpdateWidget
  }
}