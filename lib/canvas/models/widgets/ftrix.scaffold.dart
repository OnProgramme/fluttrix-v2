import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.child.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.scaffold.setting.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.scaffold.component.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.app.bar.dart';

class FTrixScaffold extends FTrixWidgetWithChild {
  FTrixScaffold(
      {String? id, super.child, super.parentId, FTrixScaffoldSetting? setting})
      : super(
            type: WidgetType.SCAFFOLD,
            setting: setting ?? FTrixScaffoldSetting.zero);

  @override
  void handleDropWidget(DroppedWidgetEvent event) {
    if (child != null) return;
    super.handleDropWidget(event);
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {}

  @override
  IWidget clone([String? parentId]) {
    return this;
  }

  @override
  Widget render() {
    final setting = this.setting as FTrixScaffoldSetting;
    return FTrixScaffoldComponent(
      onDrop: handleDropWidget,
      setting: setting,
      isSelected: isWidgetSelected,
      widget: this,
      select: select,
      appBar: FTrixAppBar(),
      child: Container(
        decoration: BoxDecoration(
          color: setting.backgroundColor,
        ),
        width: double.infinity,
        height: double.infinity,
        child: child?.render(),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "body": child?.toJson(),
      });
  }
}
