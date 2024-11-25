import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.text.setting.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.text.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.color.picker.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.padding.or.margin.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.small.input.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.textfield.dart';
import 'package:fluttrix/presentation/widgets/inputs/input.dropdown.dart';

class TextToolBarSettingComponent extends StatefulWidget {
  const TextToolBarSettingComponent({super.key, required this.widget});
  final FTrixText widget;

  @override
  State<TextToolBarSettingComponent> createState() =>
      _TextToolBarSettingComponentState();
}

class _TextToolBarSettingComponentState
    extends State<TextToolBarSettingComponent> {
  Color screenPickerColor = Colors.black;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final setting = widget.widget.setting as FTrixTextSetting;
    return Column(
      children: [
        FTextField(
          label: "Text",
          initialValue: widget.widget.text,
          maxLines: 6,
          onChanged: (value) {
            widget.widget.text = value;
            widget.widget.update();
          },
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: InputDropdown<TextAlign>(
                label: "Text Align",
                hint: "Select",
                value: setting.textAlign,
                items: setting.textAlignValue,
                onChanged: (value) {
                  setting.textAlign = value;
                  widget.widget.update();
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: InputDropdown<TextDecorationEnum>(
                label: "Text Decoration",
                hint: "Select",
                value: setting.decoration,
                items: setting.textDecorationValues,
                onChanged: (value) {
                  setting.decoration = value;
                  widget.widget.update();
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: FSmallInput(
                label: "Font Size",
                hint: "16",
                onChanged: (value) {
                  setting.fontSize = double.tryParse(value);
                  widget.widget.update();
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: InputDropdown<FontWeightEnum>(
                label: "Font Weight",
                hint: "Sélectionner",
                value: setting.fontWeight,
                items: setting.fontWeightValues,
                onChanged: (value) {
                  setting.fontWeight = value;
                  widget.widget.update();
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        FTrixColorPicker(
          initialColor: setting.color,
          onChanged: (color) {
            setting.color = color;
            widget.widget.update();
          },
        ),
        SizedBox(
          height: 10,
        ),
        FTrixEditPaddingOrMargin(
          setting: widget.widget.setting.padding,
          onUpdated: () => widget.widget.update(),
        ),
        SizedBox(
          height: 10,
        ),
        FTrixEditPaddingOrMargin(
          isMargin: true,
          setting: widget.widget.setting.margin,
          onUpdated: () => widget.widget.update(),
        ),
      ],
    );
  }
}
