import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/toolbar/ftrix.toolbar.item.dart';
import 'package:fluttrix/canvas/presentation/toolbar/components/toolbar.item.component.dart';
import 'package:get/get.dart';

final widgets = [
  FTrixToolbarItem(
    title: "Text",
    icon: Icons.text_fields,
    type: WidgetType.TEXT,
  ),
  FTrixToolbarItem(
      title: "TextField",
      icon: Icons.power_input_outlined,
      type: WidgetType.INPUT),
  FTrixToolbarItem(
      title: "Column",
      icon: Icons.view_column_outlined,
      type: WidgetType.COLUMN),
  FTrixToolbarItem(
    title: "Row",
    icon: Icons.table_rows_outlined,
    type: WidgetType.ROW,
  ),
  FTrixToolbarItem(
    title: "ListView",
    icon: Icons.list,
    type: WidgetType.LISTVIEW,
  ),
  FTrixToolbarItem(
    title: "Button",
    icon: Icons.ads_click_outlined,
    type: WidgetType.BUTTON,
  ),
  FTrixToolbarItem(
    title: "Image",
    icon: Icons.image_outlined,
    type: WidgetType.IMAGE,
  ),
];

class WidgetsToolBar extends StatelessWidget {
  const WidgetsToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: Get.height,
      padding: EdgeInsets.symmetric(vertical: 20),
      width: 300,
      child: SingleChildScrollView(
        child: LayoutGrid(
          rowGap: 10,
          columnGap: 10,
          columnSizes: [1.fr, 1.fr],
          rowSizes: widgets.map((e) => auto).toList(),
          children: widgets
              .map(
                (item) => ToolbarItemComponent(
                  item: item,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
