import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.stream.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.dart';
import 'package:fluttrix/canvas/models/builder/ftrix.widget.builder.dart';
import 'package:fluttrix/canvas/models/enums/drop.position.dart';
import 'package:fluttrix/canvas/models/utils/insert.element.on.the.list.dart';
import 'package:fluttrix/utils/message.dart';
import 'package:uuid/uuid.dart' show Uuid;

import '../enums/widget.type.dart';
import 'i.widget.dart';

typedef CustomType = void Function(IWidget widget);

abstract class FTrixWidgetChildren implements FTrixWithDropWidget {
  @override
  late String id;
  @override
  String? parentId;
  @override
  late bool isWidgetSelected;
  List<IWidget> children = [];

  FTrixWidgetChildren({this.parentId}) {
    id = Uuid().v4();
    isWidgetSelected = false;
    streamUpdate.listen(onWidgetUpdate(handleUpdateWidget));
  }

  @override
  Stream<FTrixWidgetEvent> get streamUpdate => FTrixStream.instance.stream;

  @override
  void notifyUpdate() {
    setEventType(FTrixWidgetEventType.UPDATE_ALL);
  }

  @override
  void handleDropWidget(DroppedWidgetEvent event) {
    try {
      final value = event.value;
      if (value is WidgetType) {
        throwExceptionWhenDropIsNoAuthorized(value);
        final widget = FTrixWidgetBuilder.build(value, id);
        children.add(widget);
      }
      if (value is IWidget) {
        final isWidgetExist = children.any((w) => w.id == value.id);
        if (isWidgetExist) return;
        children.add(value);
      }
      notifyUpdate();
    } catch (e) {
      //error
    }
  }

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
        return;
      }
      if (event.type == FTrixWidgetEventType.DELETE &&
          event.widget.parentId == id) {
        children.removeWhere((w) => w.id == event.widget.id);
        unselect();
        return;
      }
      if (event.type == FTrixWidgetEventType.DROP &&
          event.widget.parentId == id) {
        handleChangedPositionOfWidgetDropped(event);
      }
    };
  }

  @override
  void update() {
    setEventType(FTrixWidgetEventType.UPDATE);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "children": children.map((child) => child.toJson()).toList(),
    };
  }

  void throwExceptionWhenDropIsNoAuthorized(WidgetType type) {
    if (this.type == WidgetType.COLUMN && type == WidgetType.LISTVIEW) {
      Message.errors("Impossible de mettre une liste dans une colonne");
      throw Exception("Drop is not authorized");
    }
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

  void handleChangedPositionOfWidgetDropped(FTrixWidgetEvent event) {
    assert(event.type == FTrixWidgetEventType.DROP);
    if (event.dropPosition == DropPosition.BEFORE ||
        event.dropPosition == DropPosition.AFTER) {
      final dropWidgetIndex =
          children.indexWhere((w) => w.id == event.dragTargetWidgetId);
      if (dropWidgetIndex.isNegative) return;
      final insertWidgetIndex =
          children.indexWhere((w) => w.id == event.widget.id);
      if (insertWidgetIndex != -1) {
        final temp = children[dropWidgetIndex];
        children[dropWidgetIndex] = children[insertWidgetIndex];
        children[insertWidgetIndex] = temp;
      } else {
        insertElementOnTheList(
            list: children,
            element: event.widget,
            index: dropWidgetIndex,
            position: event.dropPosition);
      }
      notifyUpdate();
    }
  }
}

// Abstract class for widget with un-scrollable children

abstract class FTrixWidgetUnScrollChildren extends FTrixWidgetChildren {
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start;

  FTrixWidgetUnScrollChildren({super.parentId});

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "mainAxisAlignment": mainAxisAlignment.name,
        "crossAxisAlignment": crossAxisAlignment.name,
      });
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {
    type = json['type'];
    mainAxisAlignment = MainAxisAlignment.values
        .firstWhere((el) => el.name == json["mainAxisAlignment"]);
    crossAxisAlignment = CrossAxisAlignment.values
        .firstWhere((el) => el.name == json["crossAxisAlignment"]);
    children = (json['children'] as List<Map<String, dynamic>>).map((child) {
      final widget = FTrixWidgetBuilder.build(type);
      widget.loadFromJson(child);
      return widget;
    }).toList();
  }
}
