import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.stream.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/events/ftrix.delete.widget.event.data.dart';
import 'package:fluttrix/canvas/models/events/ftrix.select.widget.event.data.dart';
import 'package:fluttrix/canvas/models/events/ftrix.update.widget.event.data.dart';
import 'package:fluttrix/canvas/models/events/ftrix.wrap.parent.event.data.dart';
import 'package:uuid/uuid.dart';

typedef OnWidgetUpdate = void Function(FTrixWidgetEvent event);
typedef OnWidgetUpdateCallback = void Function(
    FTrixWidgetEventType type, IWidget widget);

abstract class IWidget {
  late String id;
  late String? parentId;
  FTrixWidgetSetting setting;
  late WidgetType type;
  late bool isWidgetSelected;
  Widget render();
  IWidget clone([String? parentId]);

  IWidget({required this.type, this.parentId, required this.setting}) {
    isWidgetSelected = false;
    id = Uuid().v4();
    FTrixStream.instance.selectWidgetEvent
        .listen(_handleListenWhenWidgetSelected);
  }

  void _handleListenWhenWidgetSelected(FTrixSelectWidgetEventData event) {
    if (isWidgetSelected && event.selectWidget.id == id && event.type == FTrixWidgetEventType.SELECT) return;
    if (isWidgetSelected || event.selectWidget.id == id) {
      isWidgetSelected = event.selectWidget.id == id;
      update();
    }
  }

  void _setEventData(FTrixEventData event) {
    FTrixStream.instance.addToStreamEvent(event);
  }

  void update() {
    _setEventData(FTrixUpdateWidgetEventData(updateWidget: this));
  }

  void select() {
    _setEventData(FTrixSelectWidgetEventData(selectWidget: this));
  }

  void delete() {
    _setEventData(FTrixDeleteWidgetEventData(deleteWidget: this));
  }

  void unselect() {
    _setEventData(FTrixUnSelectWidgetEventData(unselectWidget: this));
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type": type.name,
      "parentId": parentId,
      "setting": setting.toJson(),
    };
  }

  void loadFromJson(Map<String, dynamic> json) {
    id = json["id"];
    parentId = json["parentId"];
    type =
        WidgetType.values.firstWhere((element) => element.name == json["type"]);
  }

  void wrapParent(WidgetType type) {
    if (parentId == null) return;
    FTrixStream.instance.addToStreamEvent(FTrixWrapParentEventData(
      parentType: type,
      widgetId: id,
      currentParentId: parentId!,
    ));
  }
}
