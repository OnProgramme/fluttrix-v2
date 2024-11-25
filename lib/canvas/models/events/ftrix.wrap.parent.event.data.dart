import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';

class FTrixWrapParentEventData extends FTrixEventData {
  final WidgetType parentType;
  final String widgetId;
  final String currentParentId;

  FTrixWrapParentEventData({
    required this.currentParentId,
    required this.parentType,
    required this.widgetId,
  }) : super(FTrixWidgetEventType.WRAP_PARENT);
}
