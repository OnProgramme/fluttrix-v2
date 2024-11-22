import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.container.setting.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.children.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.button.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.column.row.setting.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.button.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.container.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.color.picker.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.padding.or.margin.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.radius.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.size.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.textfield.dart';
import 'package:fluttrix/presentation/widgets/inputs/input.dropdown.dart';

class ColumnRowToolBarSettingComponent extends StatelessWidget {
  const ColumnRowToolBarSettingComponent({super.key, required this.widget});
  final FTrixWidgetUnScrollChildren widget;

  @override
  Widget build(BuildContext context) {
    final setting = widget.setting as FTrixColumnRowSetting;
    return  Column(
      children: [
        InputDropdown<MainAxisAlignment>(
            label: "Main axis alignment",
            hint: "Sélectionner",
            value: setting.mainAxisAlignment,
            items: setting.mainAxisAlignmentValue,
            onChanged: (value) {
              setting.mainAxisAlignment = value;
              widget.update();
            }
        ),
        SizedBox(height: 10,),
        InputDropdown<CrossAxisAlignment>(
            label: "Cross axis alignment",
            hint: "Sélectionner",
            value: setting.crossAxisAlignment,
            items: setting.crossAxisAlignmentValue,
            onChanged: (value) {
              setting.crossAxisAlignment = value;
              widget.update();
            }
        )
      ],
    );
  }
}
