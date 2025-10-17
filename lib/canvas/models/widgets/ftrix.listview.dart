import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.children.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.listview.setting.dart';
import 'package:fluttrix/canvas/models/utils/normalize.json.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.listview.component.dart';

class FTrixListView extends FTrixWidgetWithChildren {
  FTrixListView({
    super.parentId,
    FTrixListViewSetting? setting,
    super.children,
  }) : super(
            type: WidgetType.LISTVIEW,
            setting: setting ?? FTrixListViewSetting.zero);

  @override
  void loadFromJson(Map<String, dynamic> json) {
    super.loadFromJson(json);
    setting = FTrixListViewSetting.fromJson(normalizeJson(json['setting']));
  }

  @override
  IWidget clone([String? parentId]) {
    return FTrixListView(
      parentId: parentId ?? this.parentId,
      setting: FTrixListViewSetting.fromJson(setting.toJson()),
      children: children.map((el) => el.clone()).toList(),
    );
  }

  @override
  Widget render() {
    final setting = this.setting as FTrixListViewSetting;
    return FTrixListViewComponent(
      setting: setting,
      widget: this,
      onTap: select,
      key: ValueKey(id),
      onDrop: handleDropWidget,
      children: children
          .map((c) => Align(
                alignment: Alignment.centerLeft,
                child: c.render(),
              ))
          .toList(),
    );
  }
}
