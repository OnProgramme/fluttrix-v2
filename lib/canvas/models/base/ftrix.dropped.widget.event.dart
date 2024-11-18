import 'package:fluttrix/canvas/models/enums/drop.position.dart';

class DroppedWidgetEvent {
  final DropPosition dropPosition;
  final dynamic value;
  DroppedWidgetEvent(this.dropPosition, this.value);
}