import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/presentation/toolbar/components/toolbar.item.component.dart';
import 'package:fluttrix/canvas/presentation/toolbar/components/widgets.toolbar.dart';
import 'package:fluttrix/utils/app.colors.dart';
import 'package:get/get.dart';

class WrapComponentListModal extends StatelessWidget {
  const WrapComponentListModal({
    super.key,
    this.excludeWidgetType,
  });
  final List<WidgetType>? excludeWidgetType;

  @override
  Widget build(BuildContext context) {
    List<WidgetType> exclude = excludeWidgetType ?? [];
    final filterWidgets =
        widgets.where((w) => !exclude.contains(w.type)).toList();
    return Dialog(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 500,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: AppColors.grey,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sélectionner un composant",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CloseButton()
                ],
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: 300,
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    LayoutGrid(
                      rowGap: 10,
                      columnGap: 10,
                      columnSizes: [1.fr, 1.fr, 1.fr, 1.fr, 1.fr],
                      rowSizes: filterWidgets.map((e) => auto).toList(),
                      children: filterWidgets
                          .map(
                            (item) => ToolbarItemComponent(
                              disableDraggable: true,
                              item: item,
                              onTap: () {
                                Get.back(result: item.type);
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
