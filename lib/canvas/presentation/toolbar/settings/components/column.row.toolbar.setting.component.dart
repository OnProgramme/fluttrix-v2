import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.children.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.column.row.setting.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.padding.or.margin.dart';
import 'package:fluttrix/presentation/widgets/inputs/input.dropdown.dart';

class ColumnRowToolBarSettingComponent extends StatelessWidget {
  const ColumnRowToolBarSettingComponent({super.key, required this.widget});
  final FTrixWidgetWithChildren widget;

  @override
  Widget build(BuildContext context) {
    final setting = widget.setting as FTrixColumnRowSetting;
    return Column(
      children: [
        InputDropdown<MainAxisAlignment>(
            label: "Main axis alignment",
            hint: "Sélectionner",
            value: setting.mainAxisAlignment,
            items: setting.mainAxisAlignmentValue,
            onChanged: (value) {
              setting.mainAxisAlignment = value;
              widget.update();
            }),
        SizedBox(
          height: 10,
        ),
        InputDropdown<CrossAxisAlignment>(
            label: "Cross axis alignment",
            hint: "Sélectionner",
            value: setting.crossAxisAlignment,
            items: setting.crossAxisAlignmentValue,
            onChanged: (value) {
              setting.crossAxisAlignment = value;
              widget.update();
            }),
        SizedBox(
          height: 10,
        ),
        FTrixEditPaddingOrMargin(
          isMargin: true,
          setting: setting.margin,
          onUpdated: () => widget.update(),
        ),
        SizedBox(
          height: 10,
        ),
        FTrixEditPaddingOrMargin(
          setting: setting.padding,
          onUpdated: () => widget.update(),
        ),
      ],
    );
  }
}
