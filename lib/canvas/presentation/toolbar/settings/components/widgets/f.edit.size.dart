import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.textfield.dart';

class FTrixEditSize extends StatefulWidget {
  const FTrixEditSize(
      {super.key, this.width, this.height, required this.onSizeChanged});
  final double? width;
  final double? height;
  final Function(double? width, double? height) onSizeChanged;

  @override
  State<FTrixEditSize> createState() => _FTrixEditSizeState();
}

class _FTrixEditSizeState extends State<FTrixEditSize> {
  final widthController = TextEditingController();
  final heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initController();
  }

  @override
  void didUpdateWidget(covariant FTrixEditSize oldWidget) {
    super.didUpdateWidget(oldWidget);
    initController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FTextField(
            controller: widthController,
            label: "Largeur",
            hint: "width",
            onChanged: (value)=> widget.onSizeChanged(
              double.tryParse(value),
              double.tryParse(heightController.text),
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: FTextField(
            controller: heightController,
            label: "Hauteur",
            hint: "height",
            onChanged: (value)=> widget.onSizeChanged(
              double.tryParse(widthController.text),
              double.tryParse(value),
            ),
          ),
        ),
      ],
    );
  }

  void initController() {
    widthController.text = widget.width?.toString() ?? "";
    heightController.text = widget.height?.toString() ?? "";
  }
}
