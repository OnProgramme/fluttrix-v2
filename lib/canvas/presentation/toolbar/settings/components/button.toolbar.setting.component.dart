import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.button.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.button.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.button.with.text.setting.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.button.with.text.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.color.picker.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.padding.or.margin.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.radius.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.size.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.textfield.dart';

class ButtonToolBarSettingComponent extends StatefulWidget {
  const ButtonToolBarSettingComponent({super.key, required this.widget});
  final FTrixButton widget;

  @override
  State<ButtonToolBarSettingComponent> createState() =>
      _ButtonToolBarSettingComponentState();
}

class _ButtonToolBarSettingComponentState
    extends State<ButtonToolBarSettingComponent> {
  @override
  Widget build(BuildContext context) {
    final setting = widget.widget.setting as FTrixButtonSetting;
    return Column(
      key: ValueKey(widget.widget.id),
      children: [
        if (setting is FTrixButtonWithTextSetting) ...[
          Builder(
            builder: (context) {
              final button = widget.widget as FTrixButtonWithText;
              return Column(
                children: [
                  FTextField(
                    label: "Text",
                    initialValue: button.text,
                    onChanged: (value) {
                      button.text = value;
                      widget.widget.update();
                    },
                  ),
                  SizedBox(height: 10),
                  FTrixColorPicker(
                    label: "Text Color",
                    initialColor: setting.textColor,
                    onChanged: (color) {
                      setting.textColor = color;
                      widget.widget.update();
                    },
                  ),
                ],
              );
            },
          )
        ],
        SizedBox(height: 10),
        FTrixEditSize(
          width: setting.width,
          height: setting.height,
          onSizeChanged: (width, height) {
            setting.width = width;
            setting.height = height;
            widget.widget.update();
          },
        ),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          value: setting.fullWidth,
          onChanged: (value) {
            setting.fullWidth = value!;
            widget.widget.update();
            setState(() {});
          },
          title: Text("Largeur de l'écran"),
        ),
        SizedBox(height: 10),
        FTrixColorPicker(
          label: "Background Color",
          initialColor: setting.color,
          onChanged: (color) {
            setting.color = color;
            widget.widget.update();
          },
        ),
        SizedBox(height: 10),
        FTrixColorPicker(
          label: "Border Color",
          initialColor: setting.borderColor,
          onChanged: (color) {
            setting.borderColor = color;
            widget.widget.update();
          },
        ),
        FTrixEditPaddingOrMargin(
          isMargin: true,
          setting: setting.margin,
          onUpdated: () => widget.widget.update(),
        ),
        SizedBox(
          height: 10,
        ),
        FTrixEditRadius(
          setting: setting.radius,
          onUpdated: () => widget.widget.update(),
        ),
        SizedBox(
          height: 10,
        ),
        FTrixEditPaddingOrMargin(
          setting: setting.padding,
          onUpdated: () => widget.widget.update(),
        ),
      ],
    );
  }
}
