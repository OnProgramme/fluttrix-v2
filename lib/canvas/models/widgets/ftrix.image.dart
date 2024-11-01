import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/utils/generateRandomImage.dart';

import '../base/i.widget.dart';

class FTrixImage extends FTrixWithoutDropWidget {
  @override
  late WidgetType type;
  String src;

  FTrixImage({this.src = ''}) {
    type = WidgetType.IMAGE;
    src = src.isEmpty ? generateRandomImage() : src;
    streamUpdate.listen(onWidgetUpdate(handleUpdateWidget));
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {
    type = WidgetType.IMAGE;
    src = json["src"];
  }

  @override
  Widget render() {
    return Image.asset(src);
  }

  @override
  void handleUpdateWidget(IWidget widget) {
    // TODO: implement handleUpdateWidget
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({
      "src": src,
    });
  }
}
