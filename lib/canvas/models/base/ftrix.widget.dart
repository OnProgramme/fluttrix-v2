import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.stream.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/builder/ftrix.widget.builder.dart';
import 'package:uuid/uuid.dart' show Uuid;

import '../enums/widget.type.dart';

abstract class FTrixWithDropWidget implements IWidget {
  @override
  late String id;
  @override
  String? parentId;
  @override
  late bool isWidgetSelected;

  FTrixWithDropWidget({this.parentId}) {
    id = Uuid().v4();
    isWidgetSelected = false;
    streamUpdate.listen(onWidgetUpdate(handleUpdateWidget));
  }

  void handleDropWidget(DroppedWidgetEvent event);

  @override
  void notifyUpdate() {
    setEventType(FTrixWidgetEventType.UPDATE_ALL);
  }

  @override
  Stream<FTrixWidgetEvent> get streamUpdate => FTrixStream.instance.stream;

  @override
  void setEventType(FTrixWidgetEventType type) {
    FTrixStream.instance
        .addToStream(FTrixWidgetEvent(id: id, widget: this, type: type));
  }

  @override
  OnWidgetUpdate onWidgetUpdate(OnWidgetUpdateCallback callback) {
    return (event) {
      isWidgetSelected = event.id == id;
      if (event.type == FTrixWidgetEventType.UPDATE ||
          event.type == FTrixWidgetEventType.DELETE) {
        callback.call(event.type, event.widget);
      }
    };
  }

  @override
  void update() {
    setEventType(FTrixWidgetEventType.UPDATE);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name};
  }

  @override
  void select() {
    setEventType(FTrixWidgetEventType.SELECT);
  }

  @override
  void delete() {
    setEventType(FTrixWidgetEventType.DELETE);
  }

  @override
  void unselect() {
    setEventType(FTrixWidgetEventType.UNSELECT);
  }

  @override
  void handleUpdateWidget(FTrixWidgetEventType type, IWidget widget) {}
}

abstract class FTrixDroppableWidgetWithSingleChild
    implements FTrixWithDropWidget {
  @override
  late String id;
  @override
  String? parentId;
  @override
  late bool isWidgetSelected;

  FTrixDroppableWidgetWithSingleChild({this.parentId}) {
    id = Uuid().v4();
    isWidgetSelected = false;
    streamUpdate.listen(onWidgetUpdate(handleUpdateWidget));
  }

  @override
  void notifyUpdate() {
    setEventType(FTrixWidgetEventType.UPDATE_ALL);
  }

  @override
  Stream<FTrixWidgetEvent> get streamUpdate => FTrixStream.instance.stream;

  @override
  void setEventType(FTrixWidgetEventType type) {
    FTrixStream.instance
        .addToStream(FTrixWidgetEvent(id: id, widget: this, type: type));
  }

  @override
  OnWidgetUpdate onWidgetUpdate(OnWidgetUpdateCallback callback) {
    return (event) {
      isWidgetSelected = event.id == id;
      if (isWidgetSelected && event.type == FTrixWidgetEventType.UPDATE) {
        callback.call(event.type, event.widget);
      }
    };
  }

  @override
  void update() {
    setEventType(FTrixWidgetEventType.UPDATE);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name};
  }

  @override
  void select() {
    setEventType(FTrixWidgetEventType.SELECT);
  }

  @override
  void delete() {
    setEventType(FTrixWidgetEventType.DELETE);
  }

  @override
  void unselect() {
    setEventType(FTrixWidgetEventType.UNSELECT);
  }

  @override
  void handleUpdateWidget(FTrixWidgetEventType type, IWidget widget) {}

  @override
  void handleDropWidget(DroppedWidgetEvent event) {
    FTrixStream.instance.addToStream(FTrixWidgetEvent(
      id: id,
      widget: event.value is WidgetType
          ? FTrixWidgetBuilder.build(event.value, parentId)
          : event.value,
      dragTargetWidgetId: id,
      type: FTrixWidgetEventType.DROP,
      dropPosition: event.dropPosition,
    ));
  }
}

abstract class FTrixWidgetWithSingleChild implements FTrixWithDropWidget {}
