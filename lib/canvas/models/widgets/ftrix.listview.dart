import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.children.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.listview.setting.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.listview.component.dart';

class FTrixListView extends FTrixWidgetWithChildren {
  FTrixListView({super.parentId, FTrixListViewSetting? setting})
      : super(
            type: WidgetType.LISTVIEW,
            setting: setting ?? FTrixListViewSetting.zero);

  @override
  void loadFromJson(Map<String, dynamic> json) {}

  @override
  IWidget clone([String? parentId]) {
    final cloneWidget = FTrixListView(
      parentId: parentId?? this.parentId,
      setting: FTrixListViewSetting.fromJson(setting.toJson()),
    );
    cloneWidget.children = children.map((el)=>el.clone(cloneWidget.id)).toList();
    return cloneWidget;
  }

  @override
  Widget render() {
    final setting = this.setting as FTrixListViewSetting;
    return FTrixListViewComponent(
      setting: setting,
      widget: this,
      onTap: select,
      key: ValueKey(id),
      children: children
          .map((c) => Align(
                alignment: Alignment.centerLeft,
                child: c.render(),
              ))
          .toList(),
      onDrop: (e) => handleDropWidget(e),
    );
  }
}
