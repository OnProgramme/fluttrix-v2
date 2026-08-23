import 'package:flutter/foundation.dart';
import 'package:fluttrix/canvas/models/base/ftrix.droppable.widget.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.stream.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.child.dart';
import 'package:fluttrix/canvas/models/builder/ftrix.widget.builder.dart';
import 'package:fluttrix/canvas/models/enums/drop.position.dart';
import 'package:fluttrix/canvas/models/events/ftrix.componentize.widget.event.data.dart';
import 'package:fluttrix/canvas/models/events/ftrix.delete.widget.event.data.dart';
import 'package:fluttrix/canvas/models/events/ftrix.drop.widget.event.data.dart';
import 'package:fluttrix/canvas/models/events/ftrix.wrap.parent.event.data.dart';
import 'package:fluttrix/canvas/models/utils/insert.element.on.the.list.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.component.dart';
import 'package:fluttrix/utils/message.dart';

import '../enums/widget.type.dart';
import 'i.widget.dart';

abstract class FTrixWidgetWithChildren extends FTrixDroppableWidget {
  List<IWidget> children = [];

  FTrixWidgetWithChildren(
      {super.parentId,
      required super.setting,
      required super.type,
      super.disableLabel,
      List<IWidget>? children}) {
    super.onStream(FTrixStream.instance.deleteWidgetEvent,
        _handleListenWhenChildDeleted);
    super.onStream(FTrixStream.instance.wrapParentWidgetEvent,
        _handleListenWhenChildWrapped);
    super.onStream(FTrixStream.instance.componentizeWidgetEvent,
        _handleListenWhenChildComponentized);
    super.onStream(
        FTrixStream.instance.dropWidgetEvent, _handleListenWhenWidgetDropped);
    this.children = children ?? [];
    for (var child in this.children) {
      child.parentId = id;
    }
  }

  @override
  void dispose() {
    for (final child in children) {
      child.dispose();
    }
    super.dispose();
  }

  @override
  void handleDropWidget(DroppedWidgetEvent event) {
    try {
      final value = event.value;
      if (value is WidgetType) {
        throwExceptionWhenDropIsNoAuthorized(value);
        children.add(FTrixWidgetBuilder.build(value, id));
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
      debugPrint('Drop error: $e');
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
    final cloneChild = child.clone(parent.id);
    cloneChild.parentId = parent.id;
    child.parentId = parent.id;
    if (parent is FTrixWidgetWithChildren) {
      parent.children.add(cloneChild);
    }
    if (parent is FTrixWidgetWithChild) {
      parent.setChild(cloneChild);
    }
    child.dispose();
    children[indexedChild] = parent;
    update();
  }

  void _handleListenWhenChildComponentized(
      FTrixComponentizeWidgetEventData event) {
    if (event.currentParentId != id || children.isEmpty) return;
    final indexedChild = children.indexWhere((el) => el.id == event.widgetId);
    if (indexedChild == -1) return;
    final child = children[indexedChild];
    final component = FTrixComponent(
      componentId: event.componentId,
      componentName: event.componentName,
      parentId: id,
      child: child,
    );
    child.parentId = component.id;
    children[indexedChild] = component;
    update();
  }

  void _handleListenWhenWidgetDropped(FTrixDropWidgetEventData event) {
    if (event.parentId != id) return;
    handleChangedPositionOfWidgetDropped(event);
  }

  void _handleListenWhenChildDeleted(FTrixDeleteWidgetEventData event) {
    if (event.deleteWidget.parentId != id) return;
    children.firstWhere((w) => w.id == event.deleteWidget.id).dispose();
    children.removeWhere((w) => w.id == event.deleteWidget.id);
    unselect();
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
        event.dropWidget.delete();
        insertElementOnTheList(
            list: children,
            element: event.dropWidget.clone(id),
            index: dropWidgetIndex,
            position: event.dropPosition);
      }
      update();
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "children": children.map((child) => child.toJson()).toList(),
      });
  }
}
