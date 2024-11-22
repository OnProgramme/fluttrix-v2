import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.container.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.button.setting.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.button.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.container.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.color.picker.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.padding.or.margin.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.radius.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.size.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.textfield.dart';

class ContainerToolBarSettingComponent extends StatelessWidget {
  const ContainerToolBarSettingComponent({super.key, required this.widget});
  final FTrixContainer widget;

  @override
  Widget build(BuildContext context) {
    final setting = widget.setting as FTrixContainerSetting;
    return  Column(
      children: [
        FTrixColorPicker(
          initialColor: setting.color,
          onChanged: (color){
            setting.color = color;
            widget.update();
          },
        ),
        FTrixEditPaddingOrMargin(
          isMargin: true,
          setting: setting.margin,
          onUpdated: () => widget.update(),
        ),
        SizedBox(
          height: 10,
        ),
        FTrixEditRadius(
          setting: setting.radius,
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
