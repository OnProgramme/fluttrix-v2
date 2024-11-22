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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        Wrap(
          spacing: 4,
          children: [
            ...[
              Colors.white,
              Color(0xFFdde5b6),
              Color(0xFFadc178),
              Color(0xFFa98467),
              Color(0xFF6c584c),
            ].map((color) => InkWell(
                  onTap: () => setColor(color),
                  child: Card(
                    elevation: 2,
                    color: color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: SizedBox(
                      width: 32,
                      height: 32,
                    ),
                  ),
                )),
            SizedBox(
              width: 40,
              child: WebColorPicker.builder(
                initialColor: selectedColor,
                onChange: (c, e) => setColor(c),
                onInput: (c, e) => setColor(c),
                builder: (context, selectedColor) {
                  return InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 2,
                      color: selectedColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: Icon(Icons.color_lens_outlined),
                      ),
                    ),
                  );
                  return Row(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        elevation: 2,
                        color: selectedColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: SizedBox(
                          width: 30,
                          height: 30,
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
              ),
            ),
          ],
        ),
      ],
    );
  }
}

