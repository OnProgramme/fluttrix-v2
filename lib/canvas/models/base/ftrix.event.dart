import 'package:fluttrix/canvas/models/base/i.widget.dart';

enum FTrixWidgetEventType{
  UPDATE,
  SELECT,
  UNSELECT,
  UPDATE_ALL,
}

class FTrixWidgetEvent{
  String id;
  IWidget widget;
  FTrixWidgetEventType type;
  FTrixWidgetEvent({required this.id, required this.widget, required this.type,});
}