import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.stream.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.button.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.textfield.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/ftrix.toolbar.settings.controller.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.textfield.dart';
import 'package:get/get.dart';

class ButtonToolBarSettingComponent extends StatelessWidget {
  const ButtonToolBarSettingComponent({super.key, required this.widget});
  final FTrixButton widget;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        FTextField(
          label: "Text",
          initialValue: widget.text,
          onChanged: (value){
            widget.text = value;
            widget.update();
          },
        ),
      ],
    );
  }
}
