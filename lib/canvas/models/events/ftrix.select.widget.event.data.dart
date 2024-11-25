import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';

class FTrixSelectWidgetEventData extends FTrixEventData {
  final IWidget selectWidget;
  FTrixSelectWidgetEventData({required this.selectWidget})
      : super(FTrixWidgetEventType.SELECT);
}

class FTrixUnSelectWidgetEventData extends FTrixSelectWidgetEventData {
  FTrixUnSelectWidgetEventData({required IWidget unselectWidget})
      : super(selectWidget: unselectWidget) {
    type = FTrixWidgetEventType.UNSELECT;
  }
}
