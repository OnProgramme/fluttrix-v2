import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.children.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';


class FTrixRow extends FTrixWidgetUnScrollChildren {

  @override
  late WidgetType type;

  FTrixRow(){
    type = WidgetType.ROW;
    streamUpdate.listen(onWidgetUpdate(handleUpdateWidget));
  }


  @override
  Widget render() {
    return Row(
      key: ValueKey(id),
      children: children.map((c)=>c.render()).toList(),
    );
  }

  @override
  void handleUpdateWidget(IWidget widget) {
    // TODO: implement handleUpdateWidget
  }
}