import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.text.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.textfield.dart';

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
    screenPickerColor = widget.widget.style.color ?? Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FTextField(
          label: "Text",
          initialValue: widget.widget.text,
          onChanged: (value) {
            widget.widget.text = value;
            widget.widget.update();
          },
        ),
        ColorPicker(
          color: screenPickerColor,
          onColorChanged: (Color color) =>
              setState(() {
                screenPickerColor = color;
                widget.widget.style = widget.widget.style.copyWith(color: color);
                widget.widget.update();
              }),
          width: 44,
          height: 44,
          borderRadius: 22,
          pickersEnabled: {
            ColorPickerType.custom: false,
            ColorPickerType.primary: false,
            ColorPickerType.accent: false,
            ColorPickerType.both: true,
            ColorPickerType.bw: false,
            ColorPickerType.customSecondary: false,
            ColorPickerType.wheel: false,
          },
        )
      ],
    );
  }
}
