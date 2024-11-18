import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.button.setting.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.button.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.color.picker.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.size.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.textfield.dart';

class ButtonToolBarSettingComponent extends StatelessWidget {
  const ButtonToolBarSettingComponent({super.key, required this.widget});
  final FTrixButton widget;

  @override
  Widget build(BuildContext context) {
    final setting = widget.setting as FTrixButtonSetting;
    return  Column(
      children: [
        FTextField(
          key: ValueKey(widget.text),
          label: "Text",
          initialValue: widget.text,
          onChanged: (value){
            widget.text = value;
            widget.update();
          },
        ),
        SizedBox(height: 10),
        FTrixEditSize(
          width: setting.style.width,
          height: setting.style.height,
          onSizeChanged: (width, height) {
            setting.style.width = width;
            setting.style.height = height;
            widget.update();
          },
        ),
        SizedBox(height: 10),
        FTrixColorPicker(
          initialColor: setting.style.color,
          onChanged: (color){
            print(color);
            setting.style.color = color;
            widget.update();
          },
        )
      ],
    );
  }
}
