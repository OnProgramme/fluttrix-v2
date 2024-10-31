import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.stream.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:uuid/uuid.dart' show Uuid;
import '../enums/widget.type.dart';

abstract class FTrixWithDropWidget implements IWidget{
  @override
  late String id;
  FTrixWithDropWidget(){
    id = Uuid().v4();
  }

  void handleDropWidget(WidgetType type);

  @override
  void notifyUpdate(){
    setEventType(FTrixWidgetEventType.UPDATE_ALL);
  }

  @override
  Stream<FTrixWidgetEvent> get streamUpdate => FTrixStream.instance.stream;

  @override
  void setEventType(FTrixWidgetEventType type) {
    FTrixStream.instance.addToStream(FTrixWidgetEvent(id: id, widget: this, type: type));
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

abstract class FTrixWithoutDropWidget implements IWidget{
  @override
  late String id;

  FTrixWithoutDropWidget(){
    id = Uuid().v4();
  }

  @override
  void notifyUpdate(){
    setEventType(FTrixWidgetEventType.UPDATE_ALL);
  }

  @override
  Stream<FTrixWidgetEvent> get streamUpdate => FTrixStream.instance.stream;

  @override
  void setEventType(FTrixWidgetEventType type) {
    FTrixStream.instance.addToStream(FTrixWidgetEvent(id: id, widget: this, type: type));
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
