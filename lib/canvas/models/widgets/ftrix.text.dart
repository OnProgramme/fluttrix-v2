import 'package:flutter/cupertino.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import '../enums/widget.type.dart';

class FTrixText extends FTrixWithoutDropWidget {
  String text;
  TextStyle? style;
  int? maxLines;

  FTrixText({this.text = "Hello Word", this.style, this.maxLines}){
    type = WidgetType.TEXT;
    streamUpdate.listen(onWidgetUpdate(handleUpdateWidget));
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
  void handleUpdateWidget(IWidget widget) {
    // TODO: implement handleUpdateWidget
  }
}
