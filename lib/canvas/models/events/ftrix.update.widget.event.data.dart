import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';

class FTrixUpdateWidgetEventData extends FTrixEventData {
  final IWidget updateWidget;
  FTrixUpdateWidgetEventData({required this.updateWidget}):super(FTrixWidgetEventType.UPDATE);
}