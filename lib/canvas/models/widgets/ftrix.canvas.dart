import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/i.ftrix.canvas.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.scaffold.dart';

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
    // TODO: implement loadFromJson
  }

  @override
  void removeWidget(String id) {
    // TODO: implement removeWidget
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  Widget render() {
    return _scaffold.render();
  }

  @override
  Stream get update => _scaffold.streamUpdate;
}
