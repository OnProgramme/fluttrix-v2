import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.children.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.drag.target.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.listview.component.dart';

class FTrixListView extends FTrixWidgetChildren {

  @override
  late WidgetType type;

  FTrixListView({super.parentId}){
    type = WidgetType.LISTVIEW;
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {
    // TODO: implement loadFromJson
  }

  @override
  Widget render() {
    return FTrixListViewComponent(
      widget: this,
      onTap: select,
      key: ValueKey(id),
      children: children.map((c)=>c.render()).toList(),
      onDrop: (e)=>handleDropWidget(e),
    );
  }

  @override
  late FTrixWidgetSetting setting;
}