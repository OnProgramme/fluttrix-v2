import 'package:fluttrix/canvas/models/base/ftrix.event.dart';

class FTrixComponentizeWidgetEventData extends FTrixEventData {
  final String widgetId;
  final String currentParentId;
  final String componentId;
  final String componentName;

  FTrixComponentizeWidgetEventData({
    required this.widgetId,
    required this.currentParentId,
    required this.componentId,
    required this.componentName,
  }) : super(FTrixWidgetEventType.COMPONENTIZE);
}
