import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.textfield.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.textfield.dart';

class TextFieldToolBarSettingComponent extends StatefulWidget {
  const TextFieldToolBarSettingComponent({super.key, required this.widget});
  final FTrixTextField widget;

  @override
  State<TextFieldToolBarSettingComponent> createState() => _TextFieldToolBarSettingComponentState();
}

class _TextFieldToolBarSettingComponentState extends State<TextFieldToolBarSettingComponent> {

  final labelController = TextEditingController();
  final hintController = TextEditingController();

  @override
  void initState() {
    super.initState();
    labelController.text = widget.widget.label??'';
    hintController.text = widget.widget.hint??'';
  }

  @override
  void didUpdateWidget(covariant TextFieldToolBarSettingComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    labelController.text = widget.widget.label??'';
    hintController.text = widget.widget.hint??'';
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        FTextField(
          label: "Label",
          controller: labelController,
          onChanged: (value){
            widget.widget.label = value;
            widget.widget.update();
          },
        ),
        SizedBox(height: 10,),
        FTextField(
          label: "Placeholder",
          controller: hintController,
          onChanged: (value){
            widget.widget.hint = value;
            widget.widget.update();
          },
        ),
      ],
    );
  }
}
