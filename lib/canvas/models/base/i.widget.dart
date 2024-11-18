import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';

typedef OnWidgetUpdate = void Function(FTrixWidgetEvent event);
typedef OnWidgetUpdateCallback = void Function(FTrixWidgetEventType type, IWidget widget);

abstract class IWidget{
  late String id;
  String? parentId;
  late WidgetType type;
  Widget render();
  void notifyUpdate();
  Stream<FTrixWidgetEvent> get streamUpdate;
  void loadFromJson(Map<String, dynamic> json);
  void setEventType(FTrixWidgetEventType type);
  OnWidgetUpdate onWidgetUpdate(OnWidgetUpdateCallback callback);
  void handleUpdateWidget(FTrixWidgetEventType type, IWidget widget);
  void update();
  Map<String, dynamic> toJson();
  late FTrixWidgetSetting setting;
  late bool isWidgetSelected;
  void select();
  void delete();
  void unselect();
}