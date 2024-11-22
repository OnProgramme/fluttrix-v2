import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/builder/ftrix.widget.builder.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.scaffold.setting.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.drag.target.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.scaffold.component.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.app.bar.dart';
import 'package:get/get.dart';

class FTrixScaffold extends FTrixWithDropWidget {
  @override
  late WidgetType type;
  IWidget? body;

  FTrixScaffold(
      {required this.setting, String? id, this.body, super.parentId}) {
    type = WidgetType.SCAFFOLD;
    streamUpdate.listen(onWidgetUpdate((type, widget) {
      if (type == FTrixWidgetEventType.DELETE && widget.id == body?.id) {
        deleteBody();
        widget.unselect();
      }
    }));
  }

  void deleteBody() {
    body = null;
  }

  void setBody(dynamic value) {
    if (body != null) return;
    if (value is WidgetType) {
      body = FTrixWidgetBuilder.build(value, id);
    }
    if (value is IWidget) {
      body = value;
    }
    notifyUpdate();
  }

  @override
  void handleDropWidget(DroppedWidgetEvent event) {
    setBody(event.value);
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {
    // TODO: implement loadFromJson
  }

  @override
  IWidget clone([String? parentId]) {
    return this;
  }

  @override
  Widget render() {
    return FTrixScaffoldComponent(
      onDrop: handleDropWidget,
      setting: setting as FTrixScaffoldSetting,
      isSelected: isWidgetSelected,
      widget: this,
      select: select,
      appBar: FTrixAppBar(),
      child: body?.render(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "body": body?.toJson(),
      });
  }

  @override
  FTrixWidgetSetting setting;
}
