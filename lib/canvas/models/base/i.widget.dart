import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';

typedef OnWidgetUpdate = void Function(FTrixWidgetEvent event);
typedef OnWidgetUpdateCallback = void Function(FTrixWidgetEventType type, IWidget widget);

abstract class IWidget{
  abstract String? parentId;
  abstract FTrixWidgetSetting setting;
  late String id;
  late WidgetType type;
  late bool isWidgetSelected;
  void notifyUpdate();
  Map<String, dynamic> toJson();
  OnWidgetUpdate onWidgetUpdate(OnWidgetUpdateCallback callback);
  Stream<FTrixWidgetEvent> get streamUpdate;
  Widget render();
  IWidget clone([String? parentId]);
  void update();
  void select();
  void delete();
  void unselect();
  void loadFromJson(Map<String, dynamic> json);
  void setEventType(FTrixWidgetEventType type);
  void handleUpdateWidget(FTrixWidgetEventType type, IWidget widget);
}