import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';


class FTrixTextField extends FTrixDroppableWidgetWithSingleChild {
  @override
  late WidgetType type;
  String? label;
  String? hint;

  FTrixTextField({
    this.label,
    this.hint,
    super.parentId,
  }) {
    type = WidgetType.INPUT;
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {
    // TODO: implement loadFromJson
  }

  @override
  Widget render() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: TextFormField(
        onTap: (){
          setEventType(FTrixWidgetEventType.SELECT);
        },
        decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6)
            )
        ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({
      "hint": hint,
      "label": label,
    });
  }

  @override
  late FTrixWidgetSetting setting;
}
