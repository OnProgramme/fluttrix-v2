import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/files/ftrix.base.file.dart';


abstract class IFTrixCanvas{
  Map<String, dynamic> toJson();
  IWidget getSelectedWidget();
  void removeWidget(String id);
  void loadFromJson(Map<String, dynamic> json);
  Widget render();
  Stream get update;
  List<FTrixBaseFile> get files;
}