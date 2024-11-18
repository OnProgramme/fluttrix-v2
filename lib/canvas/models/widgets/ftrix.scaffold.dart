import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/builder/ftrix.widget.builder.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.drag.target.dart';
import 'package:get/get.dart';

class FTrixScaffold extends FTrixWithDropWidget {
  @override
  late WidgetType type;
  IWidget? body;

  FTrixScaffold({String? id, this.body, super.parentId}) {
    type = WidgetType.SCAFFOLD;
    streamUpdate.listen(onWidgetUpdate((type, widget){
      if(type == FTrixWidgetEventType.DELETE && widget.id == body?.id){
        deleteBody();
        widget.unselect();
      }
    }));
  }


  void deleteBody(){
    body = null;
  }

  void setBody(WidgetType type) {
    body = FTrixWidgetBuilder.build(type, id);
    notifyUpdate();
  }

  @override
  void handleDropWidget(dynamic type) {
    if(type is WidgetType){
      setBody(type);
    }
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
          isExpended: true,
          onDrop:(details)=> handleDropWidget(details.data),
          child: body?.render(),
        ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({
      "body": body?.toJson(),
    });
  }

  @override
  late FTrixWidgetSetting setting;
}
