import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';

class FTrixDeleteWidgetEventData extends FTrixEventData {
  final IWidget deleteWidget;
  FTrixDeleteWidgetEventData({required this.deleteWidget}):super(FTrixWidgetEventType.DELETE);
}