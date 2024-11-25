import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.child.dart';
import 'package:fluttrix/canvas/models/base/ftrix.droppable.widget.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';

import '../enums/widget.type.dart';

class FTrixAppBar extends FTrixWidgetWithChild {
  String text;
  TextStyle style = TextStyle();

  FTrixAppBar({this.text = "Fluttrix", super.parentId})
      : super(type: WidgetType.APPBAR, setting: FTrixWidgetSetting.zero);

  @override
  void loadFromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  @override
  IWidget clone([String? parentId]) {
    return this;
  }

  @override
  Widget render() {
    return FTrixBaseComponent(
      setting: setting,
      widget: this,
      isDraggable: false,
      onTap: select,
      child: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "text": text,
      });
  }
}
