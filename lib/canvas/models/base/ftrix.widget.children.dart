import 'package:flutter/cupertino.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.stream.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.dart';
import 'package:fluttrix/canvas/models/builder/ftrix.widget.builder.dart';

import '../enums/widget.type.dart';
import 'i.widget.dart';
import 'package:uuid/uuid.dart' show Uuid;


typedef CustomType = void Function(IWidget widget);

abstract class FTrixWidgetChildren implements FTrixWithDropWidget {
  @override
  late String id;
  List<IWidget> children = [];

  FTrixWidgetChildren() {
    id = Uuid().v4();
  }

  @override
  Stream<FTrixWidgetEvent> get streamUpdate => FTrixStream.instance.stream;

  @override
  void notifyUpdate() {
    setEventType(FTrixWidgetEventType.UPDATE_ALL);
  }

  @override
  void handleDropWidget(WidgetType type) {
    final widget = FTrixWidgetBuilder.build(type);
    children.add(widget);
    notifyUpdate();
  }

  @override
  void setEventType(FTrixWidgetEventType type) {
    FTrixStream.instance.addToStream(FTrixWidgetEvent(id: id!, widget: this, type: type));
  }

  @override
  OnWidgetUpdate onWidgetUpdate(ValueSetter<IWidget> callback) {
    return (event){
      if(event.id == id && event.type == FTrixWidgetEventType.UPDATE){
        callback.call(event.widget);
      }
    };
  }


  @override
  void update() {
    setEventType(FTrixWidgetEventType.UPDATE);
  }
}