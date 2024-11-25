import 'package:fluttrix/canvas/models/base/ftrix.droppable.widget.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.stream.dart';
import 'package:fluttrix/canvas/models/builder/ftrix.widget.builder.dart';
import 'package:fluttrix/canvas/models/events/ftrix.drop.widget.event.data.dart';

import '../enums/widget.type.dart';

abstract class FTrixDroppableWidgetWithoutChild extends FTrixDroppableWidget {
  @override
  FTrixDroppableWidgetWithoutChild(
      {super.parentId, required super.type, required super.setting});

  @override
  void handleDropWidget(DroppedWidgetEvent event) {
    FTrixStream.instance.addToStreamEvent(FTrixDropWidgetEventData(
      dropWidget: event.value is WidgetType
          ? FTrixWidgetBuilder.build(event.value, parentId)
          : event.value,
      dropPosition: event.dropPosition,
      parentId: parentId!,
      dragTargetWidgetId: id,
    ));
  }
}
