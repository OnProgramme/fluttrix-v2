import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/builder/ftrix.widget.builder.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';

class FTrixWidgetJsonBuilder {
  FTrixWidgetJsonBuilder._();
  static IWidget fromJson(Map<String, dynamic> json) {
    final type = WidgetType.values.firstWhere((el) => el.name == json['type']);
    return FTrixWidgetBuilder.build(type, json["parentId"])
      ..id = json['id']
      ..loadFromJson(json);
  }
}