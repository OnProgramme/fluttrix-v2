import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/drop.position.dart';

enum FTrixWidgetEventType {
  UPDATE,
  SELECT,
  DELETE,
  UNSELECT,
  DROP,
  WRAP_PARENT,
}

class FTrixWidgetEvent {
  String id;
  IWidget widget;
  FTrixWidgetEventType type;
  final DropPosition dropPosition;
  final String? dragTargetWidgetId;
  FTrixWidgetEvent({
    required this.id,
    required this.widget,
    required this.type,
    this.dropPosition = DropPosition.NONE,
    this.dragTargetWidgetId,
  });
}


abstract class FTrixEventData {
  FTrixWidgetEventType type;
  FTrixEventData(this.type);
}