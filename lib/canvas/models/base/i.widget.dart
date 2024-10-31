import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';

typedef OnWidgetUpdate = void Function(FTrixWidgetEvent event);

abstract class IWidget{
  late String id;
  late WidgetType type;
  Widget render();
  void notifyUpdate();
  Stream<FTrixWidgetEvent> get streamUpdate;
  void loadFromJson(Map<String, dynamic> json);
  void setEventType(FTrixWidgetEventType type);
  OnWidgetUpdate onWidgetUpdate(ValueSetter<IWidget> callback);
  void handleUpdateWidget(IWidget widget);
  void update();
}