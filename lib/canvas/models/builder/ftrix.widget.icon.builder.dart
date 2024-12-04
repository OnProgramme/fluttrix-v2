import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FTrixWidgetIconBuilder {
  FTrixWidgetIconBuilder._();
  static IconData build(WidgetType type) {
    Map<WidgetType, IconData> icons = {
      WidgetType.COLUMN: LucideIcons.columns,
      WidgetType.ROW: LucideIcons.rows,
      WidgetType.CONTAINER: LucideIcons.box,
      WidgetType.IMAGE: LucideIcons.image,
      WidgetType.LISTVIEW: LucideIcons.list,
      WidgetType.SCAFFOLD: LucideIcons.layoutTemplate,
      WidgetType.INPUT: LucideIcons.formInput,
      WidgetType.BUTTON: LucideIcons.mousePointer2,
      WidgetType.BUTTON_WITH_CHILD: LucideIcons.mousePointer,
      WidgetType.ICON_BUTTON: LucideIcons.mousePointer,
      WidgetType.ICON: LucideIcons.lightbulb,
      WidgetType.TEXT: LucideIcons.text,
      WidgetType.RICH_TEXT: Icons.text_fields,
      WidgetType.APPBAR: LucideIcons.barChart2,
      WidgetType.CENTER: LucideIcons.alignCenter,
      WidgetType.WRAP: LucideIcons.layers,
      WidgetType.ALIGN: LucideIcons.alignJustify,
      WidgetType.GRIDVIEW: LucideIcons.grid,
    };
    final icon = icons[type];
    if (icon == null) {
      throw Exception('Invalid type');
    }
    return icon;
  }
}