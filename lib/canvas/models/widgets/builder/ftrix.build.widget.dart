import 'package:fluttrix/canvas/models/base/ftrix.widget.child.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.children.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/builder/ftrix.widget.json.builder.dart';

class FTrixBuildWidget {
  FTrixBuildWidget._();

  static void build(IWidget parent, Map<String, dynamic> json) {
    parent.loadFromJson(json);
    if (json["child"] != null) {
      _loadChildRecursively(parent, json["child"]);
    } else if (json["children"] != null) {
      _loadChildrenRecursively(
        parent,
        List<Map<String, dynamic>>.from(json["children"]),
      );
    }
  }

  static void _loadChildRecursively(IWidget parent, Map<String, dynamic> childJson) {
    IWidget child = FTrixWidgetJsonBuilder.fromJson(childJson);
    if (parent is FTrixWidgetWithChild) {
      parent.child = child;
    }
    if (childJson["child"] != null) {
      _loadChildRecursively(child, childJson["child"]);
    } else if (childJson["children"] != null) {
      _loadChildrenRecursively(
        child,
        List<Map<String, dynamic>>.from(childJson["children"]),
      );
    }
  }

  static void _loadChildrenRecursively(
    IWidget parent,
    List<Map<String, dynamic>> childrenJson,
  ) {
    if (parent is FTrixWidgetWithChildren) {
      parent.children = childrenJson.map((childJson) {
        IWidget child = FTrixWidgetJsonBuilder.fromJson(childJson);
        if (childJson["child"] != null) {
          _loadChildRecursively(child, childJson["child"]);
        } else if (childJson["children"] != null) {
          _loadChildrenRecursively(
              child, List<Map<String, dynamic>>.from(childJson["children"]));
        }
        return child;
      }).toList();
    }
  }
}
