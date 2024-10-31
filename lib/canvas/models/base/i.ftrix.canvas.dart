import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:uuid/uuid.dart';

import '../enums/widget.type.dart';

abstract class IFTrixCanvas{
  Map<String, dynamic> toJson();
  IWidget getSelectedWidget();
  void removeWidget(String id);
  void loadFromJson(Map<String, dynamic> json);
  Widget render();
  Stream get update;
}