import 'package:flutter/cupertino.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';

import '../enums/widget.type.dart';

class FTrixText extends FTrixDroppableWidgetWithSingleChild {
  String text;
  TextStyle style = TextStyle();
  int? maxLines;

  FTrixText({this.text = "Hello Word", this.maxLines, super.parentId}){
    type = WidgetType.TEXT;
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {
    text = json['text'];
    maxLines = json['maxLines'];
  }

  @override
  Widget render() {
    return GestureDetector(
      onTap: ()=>setEventType(FTrixWidgetEventType.SELECT),
      child: Text(
        text,
        style: style,
        maxLines: maxLines,
      ),
    );

  }

  @override
  late WidgetType type;

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({
      "text": text,
    });
  }

  @override
  late FTrixWidgetSetting setting;
}
