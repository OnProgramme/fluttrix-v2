import 'package:flutter/material.dart';
import 'package:web_color_picker/web_color_picker.dart';

class FTrixColorPicker extends StatefulWidget {
  const FTrixColorPicker({
    super.key,
    this.initialColor,
    this.label,
    required this.onChanged,
  });
  final Color? initialColor;
  final String? label;
  final ValueSetter<Color> onChanged;

  @override
  State<FTrixColorPicker> createState() => _FTrixColorPickerState();
}

class _FTrixColorPickerState extends State<FTrixColorPicker> {
  late Color selectedColor;
  @override
  void initState() {
    super.initState();
    selectedColor = widget.initialColor ?? Colors.blue;
  }

  @override
  void didUpdateWidget(covariant FTrixColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void setColor(Color color) {
    setState(() {
      selectedColor = color;
      widget.onChanged(color);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebColorPicker.builder(
      initialColor: selectedColor,
      onChange: (c, e) => setColor(c),
      onInput: (c, e) => setColor(c),
      builder: (context, selectedColor) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: selectedColor,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              widget.label ?? 'Sélectionner une couleur',
            ),
          ],
        );
      },
    );
  }
}
