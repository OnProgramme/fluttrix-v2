import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/builder/ftrix.widget.builder.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.drag.target.dart';
import 'package:get/get.dart';

class FTrixScaffold extends FTrixWithDropWidget {
  @override
  late WidgetType type;

  FTrixScaffold({String? id, this.body}) {
    type = WidgetType.SCAFFOLD;
    streamUpdate.listen(onWidgetUpdate(handleUpdateWidget));
  }

  IWidget? body;

  void setBody(WidgetType type) {
    body = FTrixWidgetBuilder.build(type);
    notifyUpdate();
  }

  @override
  void handleDropWidget(WidgetType type) {
    setBody(type);
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {
    // TODO: implement loadFromJson
  }


  @override
  Widget render() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Fluttrix",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: FTrixDragTarget(
          onDrop: handleDropWidget,
          child: body?.render(),
        ),
      ),
    );
  }

  @override
  void handleUpdateWidget(IWidget widget) {
    // TODO: implement handleUpdateWidget
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({
      "body": body?.toJson(),
    });
  }
}
