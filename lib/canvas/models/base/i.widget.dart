import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.stream.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/events/ftrix.componentize.widget.event.data.dart';
import 'package:fluttrix/canvas/models/events/ftrix.delete.widget.event.data.dart';
import 'package:fluttrix/canvas/models/events/ftrix.select.widget.event.data.dart';
import 'package:fluttrix/canvas/models/events/ftrix.update.widget.event.data.dart';
import 'package:fluttrix/canvas/models/events/ftrix.wrap.parent.event.data.dart';
import 'package:uuid/uuid.dart';

abstract class IWidget {
  late String id;
  late String? parentId;
  FTrixWidgetSetting setting;
  late WidgetType type;
  late bool isWidgetSelected;
  late bool disableLabel;
  Widget render();
  IWidget clone([String? parentId]);

  final List<StreamSubscription<dynamic>> _subscriptions = [];

  IWidget({required this.type, this.parentId, required this.setting, this.disableLabel = false}) {
    isWidgetSelected = false;
    id = Uuid().v4();
    onStream(
      FTrixStream.instance.selectWidgetEvent,
      _handleListenWhenWidgetSelected,
    );
  }

  void onStream<T>(Stream<T> stream, void Function(T event) handler) {
    _subscriptions.add(stream.listen(handler));
  }

  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
  }

  void _handleListenWhenWidgetSelected(FTrixSelectWidgetEventData event) {
    if (isWidgetSelected &&
        event.selectWidget.id == id &&
        event.type == FTrixWidgetEventType.SELECT) return;
    if (isWidgetSelected || event.selectWidget.id == id) {
      isWidgetSelected = event.selectWidget.id == id;
    }
  }


  void handleDropWidget(DroppedWidgetEvent event);

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

  void loadFromJson(Map<String, dynamic> json){
    id = json['id'];
    type = WidgetType.values.firstWhere((el) => el.name == json['type']);
    parentId = json['parentId'];
  }

  void wrapParent(WidgetType type) {
    if (parentId == null) return;
    FTrixStream.instance.addToStreamEvent(FTrixWrapParentEventData(
      parentType: type,
      widgetId: id,
      currentParentId: parentId!,
    ));
  }

  void componentize({
    required String componentId,
    required String componentName,
  }) {
    if (parentId == null) return;
    FTrixStream.instance.addToStreamEvent(FTrixComponentizeWidgetEventData(
      widgetId: id,
      currentParentId: parentId!,
      componentId: componentId,
      componentName: componentName,
    ));
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
