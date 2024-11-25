import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.rich.text.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.text.setting.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.rich.text.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.text.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.color.picker.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.padding.or.margin.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.small.input.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.textfield.dart';
import 'package:fluttrix/presentation/widgets/buttons/f.add.button.dart';
import 'package:fluttrix/presentation/widgets/inputs/input.dropdown.dart';
import 'package:fluttrix/utils/app.colors.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RichTextToolBarSettingComponent extends StatefulWidget {
  const RichTextToolBarSettingComponent({super.key, required this.widget});
  final FTrixRichText widget;

  @override
  State<RichTextToolBarSettingComponent> createState() =>
      _RichTextToolBarSettingComponentState();
}

class _RichTextToolBarSettingComponentState
    extends State<RichTextToolBarSettingComponent> {
  Color screenPickerColor = Colors.black;

  late FTrixTextSetting currentSetting;

  @override
  void initState() {
    super.initState();
    currentSetting = widget.widget.setting as FTrixTextSetting;
  }

  @override
  Widget build(BuildContext context) {
    final setting = widget.widget.setting as FTrixTextSetting;
    final texts = widget.widget.text;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Text"),
            Radio(
              activeColor: AppColors.buttonColor,
              value: setting,
              groupValue: currentSetting,
              onChanged: (value) {
                currentSetting = value!;
                setState(() {});
              },
            )
          ],
        ),
        SizedBox(height: 10),
        ...texts.map((text) {
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: FTextField(
                    initialValue: text.text,
                    maxLines: 6,
                    onChanged: (value) {
                      text.text = value;
                      widget.widget.update();
                    },
                  ),
                ),
                if (text.index <= 1)
                  SizedBox(width: 10),
                if (text.index > 1)
                  IconButton(
                    padding: EdgeInsets.all(7),
                    onPressed: () {},
                    icon: Icon(
                      LucideIcons.trash2,
                      size: 20,
                    ),
                    color: Colors.red,
                    constraints: BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),
                  ),
                Radio(
                  activeColor: AppColors.buttonColor,
                  value: text.setting,
                  groupValue: currentSetting,
                  onChanged: (value) {
                    currentSetting = value!;
                    setState(() {});
                  },
                )
              ],
            ),
          );
        }),
        FAddButton(
          title: "Ajouter un text",
          onPressed: () {
            widget.widget.addText();
            setState(() {});
          },
        ),
        SizedBox(
          height: 15,
        ),
        Column(
          key: ValueKey(currentSetting.hashCode),
          children: [
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
                    value: currentSetting.decoration,
                    items: currentSetting.textDecorationValues,
                    onChanged: (value) {
                      currentSetting.decoration = value;
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
                      currentSetting.fontSize = double.tryParse(value);
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
                    value: currentSetting.fontWeight,
                    items: currentSetting.fontWeightValues,
                    onChanged: (value) {
                      currentSetting.fontWeight = value;
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
              initialColor: currentSetting.color,
              onChanged: (color) {
                currentSetting.color = color;
                widget.widget.update();
              },
            ),
          ],
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
