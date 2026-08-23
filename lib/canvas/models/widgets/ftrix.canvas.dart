import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.stream.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.child.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.children.dart';
import 'package:fluttrix/canvas/models/base/i.ftrix.canvas.dart';
import 'package:fluttrix/canvas/models/builder/ftrix.widget.json.builder.dart';
import 'package:fluttrix/canvas/models/generator/ftrix.widget.generator.dart';
import 'package:fluttrix/canvas/models/events/ftrix.select.widget.event.data.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.scaffold.setting.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.scaffold.dart';
import 'package:fluttrix/files/ftrix.base.file.dart';
import 'package:fluttrix/files/ftrix.file.dart';
import 'package:fluttrix/files/ftrix.folder.dart';

import '../base/i.widget.dart';

class FTrixCanvas implements IFTrixCanvas {
  final _scaffold = FTrixScaffold(
    setting: FTrixScaffoldSetting.zero,
  );

  @override
  IWidget getSelectedWidget() {
    return _scaffold;
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {
    _disposeSubtree();
    _scaffold.reset();
    _scaffold.loadFromJson(json);
    if (json["child"] != null) {
      _loadChildRecursively(_scaffold, json["child"]);
    } else if (json["children"] != null) {
      _loadChildrenRecursively(
        _scaffold,
        List<Map<String, dynamic>>.from(json["children"]),
      );
    }
  }

  void _disposeSubtree() {
    final child = _scaffold.child;
    if (child != null) {
      child.dispose();
    }
    _scaffold.appBar?.dispose();
  }

  void _loadChildRecursively(IWidget parent, Map<String, dynamic> childJson) {
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

  void _loadChildrenRecursively(
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

  @override
  Map<String, dynamic> toJson() {
    return _scaffold.toJson();
  }

  @override
  Widget render() {
    return _CanvasRender(
      widget: _scaffold,
    );
  }

  @override
  Stream<FTrixEventData> get update => FTrixStream.instance.updateCanvas;

  List<String> get widgetsImported =>
      FTrixWidgetGenerator.collectComponents(toJson())
          .map((component) =>
              FTrixWidgetGenerator.componentFileName(component.name))
          .toList();

  @override
  List<FTrixBaseFile> get files {
    final screenJson = toJson();
    final components = FTrixWidgetGenerator.collectComponents(screenJson);

    final componentFiles = components.map((component) {
      return FTrixFile(
        FTrixWidgetGenerator.componentFileName(component.name),
        content: FTrixWidgetGenerator.generateComponentFile(
          componentName: component.name,
          componentJson: component.json,
        ),
      );
    }).toList();

    final homeBuffer = StringBuffer();
    for (final component in components) {
      homeBuffer.writeln(
          "import 'widgets/${FTrixWidgetGenerator.componentFileName(component.name)}';");
    }
    if (components.isNotEmpty) {
      homeBuffer.writeln();
    }
    homeBuffer.write(FTrixWidgetGenerator.generateCodeFromJson(
      jsonMap: screenJson,
      className: 'Home',
      stateType: FTrixWidgetStateType.STATEFUL,
    ));

    final libFolder = FTrixFolder(name: "Lib", files: [
      FTrixFolder(name: "home", files: [
        FTrixFile('home.dart', content: homeBuffer.toString()),
      ]),
      if (componentFiles.isNotEmpty)
        FTrixFolder(name: "widgets", files: componentFiles),
    ]);

    return [libFolder];
  }

  @override
  void select() {
    _scaffold.select();
  }
}

class _CanvasRender extends StatefulWidget {
  const _CanvasRender({required this.widget});
  final IWidget widget;

  @override
  State<_CanvasRender> createState() => _CanvasRenderState();
}

class _CanvasRenderState extends State<_CanvasRender> {
  StreamSubscription<FTrixEventData>? _updateSubscription;
  StreamSubscription<FTrixSelectWidgetEventData>? _selectSubscription;

  @override
  void initState() {
    super.initState();
    _updateSubscription = FTrixStream.instance.updateCanvas.listen((e) {
      if (mounted) setState(() {});
    });
    _selectSubscription = FTrixStream.instance.selectWidgetEvent.listen((e) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _updateSubscription?.cancel();
    _selectSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.widget.render();
  }
}
