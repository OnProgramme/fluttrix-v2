import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/utils/generateRandomImage.dart';

import '../base/i.widget.dart';

class FTrixButton extends FTrixWithoutDropWidget {
  @override
  late WidgetType type;
  String text;
  VoidCallback? onPressed;

  FTrixButton({
    this.text = 'Button',
    this.onPressed,
  }) {
    type = WidgetType.BUTTON;
    streamUpdate.listen(onWidgetUpdate(handleUpdateWidget));
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {

  }


  @override
  Widget render() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
        ),
        onPressed: (){
          setEventType(FTrixWidgetEventType.SELECT);
        },
        child: Text(text, style: TextStyle(
          color: Colors.white,
        ),),
      ),
    );
  }

  @override
  void handleUpdateWidget(IWidget widget) {
    // TODO: implement handleUpdateWidget
  }
}
