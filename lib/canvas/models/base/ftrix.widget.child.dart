import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.stream.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/builder/ftrix.widget.builder.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:uuid/uuid.dart' show Uuid;


abstract class FTrixWidgetWithChild implements FTrixWithDropWidget {

  @override
  late String id;

  @override
  late bool isWidgetSelected;

  @override
  String? parentId;
  abstract IWidget? child;

  FTrixWidgetWithChild({this.parentId}) {
    id = Uuid().v4();
    isWidgetSelected = false;
    streamUpdate.listen(onWidgetUpdate(handleUpdateWidget));
  }

  @override
  void update() {
    setEventType(FTrixWidgetEventType.UPDATE);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
    };
  }

  @override
  OnWidgetUpdate onWidgetUpdate(OnWidgetUpdateCallback callback) {
    return (event) {
      isWidgetSelected = event.id == id;
      if (event.type == FTrixWidgetEventType.UPDATE) {
        callback.call(event.type, event.widget);
      }
      if(event.type == FTrixWidgetEventType.DELETE && event.widget.parentId == id) {
        deleteChild();
      }
    };
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
  Stream<FTrixWidgetEvent> get streamUpdate => FTrixStream.instance.stream;

  @override
  void setEventType(FTrixWidgetEventType type) {
    FTrixStream.instance
        .addToStream(FTrixWidgetEvent(id: id, widget: this, type: type));
  }

  @override
  void handleUpdateWidget(FTrixWidgetEventType type, IWidget widget) {
  }

  @override
  void notifyUpdate() {
    setEventType(FTrixWidgetEventType.UPDATE_ALL);
  }


  @override
  void handleDropWidget(DroppedWidgetEvent event) {

    if(event.value is WidgetType) {
      setChild(FTrixWidgetBuilder.build(event.value, id));
      return;
    }
    if(event.value is! IWidget) return;
    IWidget widget = event.value;
    if(id == widget.id) return;
    widget.delete();
    final copyWidget = widget.clone(id);
    setChild(copyWidget);
    notifyUpdate();
  }


  void deleteChild() {
    child = null;
    notifyUpdate();
  }

  void setChild(IWidget child) {
    this.child = child;
    notifyUpdate();
  }
}
