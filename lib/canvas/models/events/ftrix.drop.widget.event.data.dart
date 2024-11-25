import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/drop.position.dart';

class FTrixDropWidgetEventData extends FTrixEventData {
  final DropPosition dropPosition;
  final IWidget dropWidget;
  final String parentId;
  final String dragTargetWidgetId;

  FTrixDropWidgetEventData({
    required this.parentId,
    required this.dropWidget,
    required this.dropPosition,
    required this.dragTargetWidgetId,
  }) : super(FTrixWidgetEventType.DROP);
}
