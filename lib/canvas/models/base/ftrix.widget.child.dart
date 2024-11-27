import 'package:fluttrix/canvas/models/base/ftrix.droppable.widget.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.stream.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.children.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/builder/ftrix.widget.builder.dart';
import 'package:fluttrix/canvas/models/builder/ftrix.widget.json.builder.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/events/ftrix.delete.widget.event.data.dart';
import 'package:fluttrix/canvas/models/events/ftrix.wrap.parent.event.data.dart';

abstract class FTrixWidgetWithChild extends FTrixDroppableWidget {
  IWidget? child;

  FTrixWidgetWithChild(
      {super.parentId,
      required super.setting,
      required super.type,
      this.child}) {
    FTrixStream.instance.wrapParentWidgetEvent
        .listen(_handleListenWhenChildWrapped);
    FTrixStream.instance.deleteWidgetEvent
        .listen(_handleListenWhenChildDeleted);
  }

  @override
  void handleDropWidget(DroppedWidgetEvent event) {
    if (event.value is WidgetType) {
      setChild(FTrixWidgetBuilder.build(event.value, id));
      return;
    }
    if (event.value is! IWidget) return;
    IWidget widget = event.value;
    if (id == widget.id) return;
    widget.delete();
    final copyWidget = widget.clone(id);
    setChild(copyWidget);
  }

  void deleteChild() {
    child = null;
    update();
  }

  void setChild(IWidget? child) {
    this.child = child;
    update();
  }

  void _handleListenWhenChildWrapped(FTrixWrapParentEventData event) {
    if (event.currentParentId != id || child?.id != event.widgetId) return;
    final parent = FTrixWidgetBuilder.build(event.parentType, id);
    final cloneChild = child!.clone(parent.id);
    if (parent is FTrixWidgetWithChildren) {
      parent.children.add(cloneChild);
    }
    if (parent is FTrixWidgetWithChild) {
      parent.setChild(cloneChild);
    }
    child = parent;
  }

  void _handleListenWhenChildDeleted(FTrixDeleteWidgetEventData event) {
    if (event.deleteWidget.parentId != id) return;
    setChild(null);
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({"child": child?.toJson()});
  }
}
