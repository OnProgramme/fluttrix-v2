import 'package:flutter/cupertino.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';

class FTrixToolbarItem {
  final String title;
  final IconData icon;
  final WidgetType type;
  FTrixToolbarItem({required this.title, required this.icon, required this.type});
}