import 'package:flutter/cupertino.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.stream.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.child.dart';
import 'package:fluttrix/canvas/models/base/ftrix.droppable.widget.dart';
import 'package:fluttrix/canvas/models/builder/ftrix.widget.builder.dart';
import 'package:fluttrix/canvas/models/builder/ftrix.widget.json.builder.dart';
import 'package:fluttrix/canvas/models/enums/drop.position.dart';
import 'package:fluttrix/canvas/models/events/ftrix.delete.widget.event.data.dart';
import 'package:fluttrix/canvas/models/events/ftrix.drop.widget.event.data.dart';
import 'package:fluttrix/canvas/models/events/ftrix.wrap.parent.event.data.dart';
import 'package:fluttrix/canvas/models/utils/insert.element.on.the.list.dart';
import 'package:fluttrix/utils/message.dart';
import '../enums/widget.type.dart';
import 'i.widget.dart';


abstract class FTrixWidgetWithChildren extends FTrixDroppableWidget {
  List<IWidget> children = [];

  FTrixWidgetWithChildren({super.parentId, required super.setting, required super.type}){
    FTrixStream.instance.deleteWidgetEvent
        .listen(_handleListenWhenChildDeleted);
    FTrixStream.instance.wrapParentWidgetEvent
        .listen(_handleListenWhenChildWrapped);
    FTrixStream.instance.dropWidgetEvent.listen(_handleListenWhenWidgetDropped);
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
        final copyWidget = value.clone(id);
        value.delete();
        children.add(copyWidget);
      }
      update();
    } catch (e) {
      //error
    }
  }


  void throwExceptionWhenDropIsNoAuthorized(WidgetType type) {
    if (this.type == WidgetType.COLUMN && type == WidgetType.LISTVIEW) {
      Message.errors("Impossible de mettre une liste dans une colonne");
      throw Exception("Drop is not authorized");
    }
  }

  void _handleListenWhenChildWrapped(FTrixWrapParentEventData event) {
    if (event.currentParentId != id || children.isEmpty) return;
    final parent = FTrixWidgetBuilder.build(event.parentType, id);
    final indexedChild = children.indexWhere((el) => el.id == event.widgetId);
    if (indexedChild == -1) return;
    final child = children[indexedChild];
    child.parentId = parent.id;
    if (parent is FTrixWidgetWithChildren) {
      parent.children.add(child);
    }
    if (parent is FTrixWidgetWithChild) {
      parent.setChild(child);
    }
    children[indexedChild] = parent;
    update();
  }

  void _handleListenWhenWidgetDropped(FTrixDropWidgetEventData event) {
    if (event.parentId != id) return;
    handleChangedPositionOfWidgetDropped(event);
  }

  void _handleListenWhenChildDeleted(FTrixDeleteWidgetEventData event) {
    if (event.deleteWidget.parentId != id) return;
    children.removeWhere((w) => w.id == event.deleteWidget.id);
  }

  void handleChangedPositionOfWidgetDropped(FTrixDropWidgetEventData event) {
    assert(event.type == FTrixWidgetEventType.DROP);
    if (event.dropPosition == DropPosition.BEFORE ||
        event.dropPosition == DropPosition.AFTER) {
      final dropWidgetIndex =
          children.indexWhere((w) => w.id == event.dragTargetWidgetId);
      if (dropWidgetIndex.isNegative) return;
      final insertWidgetIndex =
          children.indexWhere((w) => w.id == event.dropWidget.id);
      if (insertWidgetIndex != -1) {
        final temp = children[dropWidgetIndex];
        children[dropWidgetIndex] = children[insertWidgetIndex];
        children[insertWidgetIndex] = temp;
      } else {
        insertElementOnTheList(
            list: children,
            element: event.dropWidget,
            index: dropWidgetIndex,
            position: event.dropPosition);
      }
      update();
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({
      "children": children.map((child) => child.toJson()).toList(),
    });
  }
}
