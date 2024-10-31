import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/utils/generateRandomImage.dart';

import '../base/ftrix.stream.dart';
import '../base/i.widget.dart';

class FTrixTextField extends FTrixWithoutDropWidget {
  @override
  late WidgetType type;
  String? label;
  String? hint;

  FTrixTextField({
    this.label,
    this.hint,
  }) {
    type = WidgetType.INPUT;
    streamUpdate.listen(onWidgetUpdate(handleUpdateWidget));
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
  void handleUpdateWidget(IWidget widget) {
    // TODO: implement handleUpdateWidget
  }
}
