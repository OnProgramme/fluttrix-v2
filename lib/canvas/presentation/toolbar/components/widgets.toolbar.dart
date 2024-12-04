import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:fluttrix/canvas/models/builder/ftrix.widget.icon.builder.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/toolbar/ftrix.toolbar.item.dart';
import 'package:fluttrix/canvas/presentation/icons/choose.icon.modal.dart';
import 'package:fluttrix/canvas/presentation/toolbar/components/toolbar.item.component.dart';
import 'package:fluttrix/utils/app.colors.dart';
import 'package:get/get.dart';

final widgets = [
  FTrixToolbarItem(
    title: "Text",
    icon: FTrixWidgetIconBuilder.build(WidgetType.TEXT),
    type: WidgetType.TEXT,
  ),
  FTrixToolbarItem(
    title: "RichText",
    icon: FTrixWidgetIconBuilder.build(WidgetType.RICH_TEXT),
    type: WidgetType.RICH_TEXT,
  ),
  FTrixToolbarItem(
      title: "TextField",
      icon: FTrixWidgetIconBuilder.build(WidgetType.INPUT),
      type: WidgetType.INPUT),
  FTrixToolbarItem(
      title: "Column",
      icon: FTrixWidgetIconBuilder.build(WidgetType.COLUMN),
      type: WidgetType.COLUMN),
  FTrixToolbarItem(
    title: "Row",
    icon: FTrixWidgetIconBuilder.build(WidgetType.ROW),
    type: WidgetType.ROW,
  ),
  FTrixToolbarItem(
    title: "Wrap",
    icon: FTrixWidgetIconBuilder.build(WidgetType.WRAP),
    type: WidgetType.WRAP,
  ),
  FTrixToolbarItem(
    title: "ListView",
    icon: FTrixWidgetIconBuilder.build(WidgetType.LISTVIEW),
    type: WidgetType.LISTVIEW,
  ),
  FTrixToolbarItem(
    title: "GridView",
    icon: FTrixWidgetIconBuilder.build(WidgetType.GRIDVIEW),
    type: WidgetType.GRIDVIEW,
  ),
  FTrixToolbarItem(
    title: "Button",
    icon: FTrixWidgetIconBuilder.build(WidgetType.BUTTON),
    type: WidgetType.BUTTON,
  ),
  FTrixToolbarItem(
    title: "Button2",
    icon: FTrixWidgetIconBuilder.build(WidgetType.BUTTON),
    type: WidgetType.BUTTON_WITH_CHILD,
  ),
  FTrixToolbarItem(
    title: "IconButton",
    icon: FTrixWidgetIconBuilder.build(WidgetType.ICON_BUTTON),
    type: WidgetType.ICON_BUTTON,
  ),
  FTrixToolbarItem(
    title: "Icon",
    icon: FTrixWidgetIconBuilder.build(WidgetType.ICON),
    type: WidgetType.ICON,
  ),
  FTrixToolbarItem(
    title: "Image",
    icon: FTrixWidgetIconBuilder.build(WidgetType.IMAGE),
    type: WidgetType.IMAGE,
  ),
  FTrixToolbarItem(
    title: "Container",
    icon: FTrixWidgetIconBuilder.build(WidgetType.CONTAINER),
    type: WidgetType.CONTAINER,
  ),
  FTrixToolbarItem(
    title: "Center",
    icon: FTrixWidgetIconBuilder.build(WidgetType.CENTER),
    type: WidgetType.CENTER,
  ),
  FTrixToolbarItem(
    title: "Align",
    icon: FTrixWidgetIconBuilder.build(WidgetType.ALIGN),
    type: WidgetType.ALIGN,
  ),
];

class WidgetsToolBar extends StatelessWidget {
  const WidgetsToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      height: Get.height,
      padding: EdgeInsets.symmetric(vertical: 10),
      width: 300,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            LayoutGrid(
              rowGap: 10,
              columnGap: 10,
              columnSizes: [1.fr, 1.fr, 1.fr],
              rowSizes: widgets.map((e) => auto).toList(),
              children: widgets
                  .map(
                    (item) => ToolbarItemComponent(
                      item: item,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
