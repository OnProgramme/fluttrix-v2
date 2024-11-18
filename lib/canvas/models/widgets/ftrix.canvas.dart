import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/i.ftrix.canvas.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.scaffold.dart';
import 'package:fluttrix/files/ftrix.base.file.dart';
import 'package:fluttrix/files/ftrix.file.dart';
import 'package:fluttrix/files/ftrix.folder.dart';

import '../base/i.widget.dart';

class FTrixCanvas implements IFTrixCanvas{

  final _scaffold = FTrixScaffold();

  @override
  IWidget getSelectedWidget() {
    // TODO: implement getSelectedWidget
    throw UnimplementedError();
  }

  @override
  void loadFromJson(Map<String, dynamic> json) {
    _scaffold.loadFromJson(json);
  }

  @override
  void removeWidget(String id) {
    // TODO: implement removeWidget
  }

  @override
  Map<String, dynamic> toJson() {
    return _scaffold.toJson();
  }

  @override
  Widget render() {
    return _scaffold.render();
  }

  @override
  Stream get update => _scaffold.streamUpdate.where(shouldTriggerUpdate);

  bool shouldTriggerUpdate(FTrixWidgetEvent event) {
    return event.type == FTrixWidgetEventType.UPDATE ||
        event.type == FTrixWidgetEventType.DELETE ||
        event.type == FTrixWidgetEventType.SELECT ||
        event.type == FTrixWidgetEventType.UPDATE_ALL;
  }

  List<String> get widgetsImported => [WidgetType.INPUT,WidgetType.TEXT,WidgetType.BUTTON]
      .where((el) => toJson().toString().contains('type: ${el.name}'))
      .map((type)=>_customFileNameByType(type))
      .toList();

  @override
  List<FTrixBaseFile> get files{
    final libFolder = FTrixFolder(name: "Lib", files: [
      FTrixFolder(name: "home", files: [
        FTrixFile('home.dart')
      ])
    ]);

    if(widgetsImported.isNotEmpty){
      libFolder.files.add(FTrixFolder(name: "widgets", files: widgetsImported.map((name){
        return FTrixFile(name);
      }).toList()));
    }
    
    
    return [libFolder];
  }

  String _customFileNameByType(WidgetType type){
    switch(type){
      case WidgetType.INPUT:
        return "ftrix.input.dart";
      case WidgetType.TEXT:
        return "ftrix.text.dart";
      case WidgetType.BUTTON:
        return "ftrix.button.dart";
      default:
        throw Exception("Invalid type");
    }

  }
}
