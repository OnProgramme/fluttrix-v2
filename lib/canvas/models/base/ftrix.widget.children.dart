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
    FTrixStream.instance
        .addToStream(FTrixWidgetEvent(id: id!, widget: this, type: type));
  }

  @override
  OnWidgetUpdate onWidgetUpdate(ValueSetter<IWidget> callback) {
    return (event) {
      if (event.id == id && event.type == FTrixWidgetEventType.UPDATE) {
        callback.call(event.widget);
      }
    };
  }

  @override
  void update() {
    setEventType(FTrixWidgetEventType.UPDATE);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "children": children.map((child) => child.toJson()).toList(),
    };
  }
}

abstract class FTrixWidgetUnScrollChildren extends FTrixWidgetChildren {
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start;

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "mainAxisAlignment": mainAxisAlignment.name,
        "crossAxisAlignment": crossAxisAlignment.name,
      });
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {
    type = json['type'];
    mainAxisAlignment = MainAxisAlignment.values
        .firstWhere((el) => el.name == json["mainAxisAlignment"]);
    crossAxisAlignment = CrossAxisAlignment.values
        .firstWhere((el) => el.name == json["crossAxisAlignment"]);
    children = (json['children'] as List<Map<String, dynamic>>).map((child) {
      final widget = FTrixWidgetBuilder.build(type);
      widget.loadFromJson(child);
      return widget;
    }).toList();
  }
}
