import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.children.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/toolbar/ftrix.toolbar.item.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.align.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.button.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.column.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.container.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.image.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.listview.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.rich.text.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.row.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.scaffold.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.text.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.textfield.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/ftrix.toolbar.settings.controller.dart';
import 'package:fluttrix/canvas/presentation/toolbar/components/widgets.toolbar.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/align.toolbar.setting.component.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/button.toolbar.setting.component.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/column.row.toolbar.setting.component.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/container.toolbar.setting.component.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/image.toolbar.setting.component.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/listview.toolbar.setting.component.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/rich.text.toolbar.setting.component.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/scaffold.toolbar.setting.component.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/text.toolbar.setting.component.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/textfield.toolbar.setting.component.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.size.dart';
import 'package:fluttrix/main.dart';
import 'package:fluttrix/presentation/widgets/inputs/input.dropdown.dart';
import 'package:fluttrix/utils/app.colors.dart';
import 'package:get/get.dart';

class ToolbarSettingsComponent extends GetView<FTrixToolbarSettingsController> {
  const ToolbarSettingsComponent({super.key});

  IWidget? get widget => controller.selectedWidget.value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: AppColors.primary,
      ),
      child: Obx(() {
        return Column(
          children: [
            if (widget != null)
              Container(
                height: 60,
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.background))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          widgets
                              .firstWhere((w) => w.type == widget?.type,
                              orElse: () => FTrixToolbarItem(
                                type: WidgetType.SCAFFOLD,
                                title: "Scaffold",
                                icon: Icons.app_blocking,
                              ))
                              .icon,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(widget?.type.name.capitalizeFirst?.toUpperCase() ??
                            ''),
                      ],
                    ),
                    if (controller.selectedWidget.value?.parentId != null)
                      IconButton(
                        onPressed: controller.selectedWidget.value?.delete,
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )
                  ],
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (controller.selectedWidget.value is FTrixTextField) ...[
                    TextFieldToolBarSettingComponent(
                        widget: controller.selectedWidget.value as FTrixTextField)
                  ],
                  if (controller.selectedWidget.value is FTrixButton) ...[
                    ButtonToolBarSettingComponent(
                        widget: controller.selectedWidget.value as FTrixButton)
                  ],
                  if (controller.selectedWidget.value is FTrixText) ...[
                    TextToolBarSettingComponent(
                        widget: controller.selectedWidget.value as FTrixText)
                  ],
                  if (controller.selectedWidget.value is FTrixRichText) ...[
                    RichTextToolBarSettingComponent(
                        widget: controller.selectedWidget.value as FTrixRichText)
                  ],
                  if (controller.selectedWidget.value is FTrixImage) ...[
                    ImageToolBarSettingComponent(
                        widget: controller.selectedWidget.value as FTrixImage)
                  ],
                  if (controller.selectedWidget.value is FTrixListView) ...[
                    ListViewToolBarSettingComponent(
                        widget: controller.selectedWidget.value as FTrixListView)
                  ],
                  if (controller.selectedWidget.value is FTrixContainer) ...[
                    ContainerToolBarSettingComponent(
                        widget: controller.selectedWidget.value as FTrixContainer)
                  ],
                  if (controller.selectedWidget.value is FTrixScaffold) ...[
                    ScaffoldToolBarSettingComponent(
                      widget: controller.selectedWidget.value as FTrixScaffold,
                    )
                  ],
                  if (controller.selectedWidget.value is FTrixAlign) ...[
                    AlignToolBarSettingComponent(
                      widget: controller.selectedWidget.value as FTrixAlign,
                    )
                  ],
                  if (controller.selectedWidget.value is FTrixColumn || controller.selectedWidget.value is FTrixRow) ...[
                    ColumnRowToolBarSettingComponent(widget: controller.selectedWidget.value as FTrixWidgetWithChildren)
                  ],
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
