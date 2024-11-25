import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.align.setting.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.align.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.alignment.dart';

class AlignToolBarSettingComponent extends StatefulWidget {
  const AlignToolBarSettingComponent({super.key, required this.widget});
  final FTrixAlign widget;

  @override
  State<AlignToolBarSettingComponent> createState() =>
      _AlignToolBarSettingComponentState();
}

class _AlignToolBarSettingComponentState
    extends State<AlignToolBarSettingComponent> {
  @override
  Widget build(BuildContext context) {
    final setting = widget.widget.setting as FTrixAlignSetting;
    return Column(
      children: [
        FTrixEditAlignment(
          alignment: setting.alignment,
          onChanged: (alignment) {
            setting.alignment = alignment;
            widget.widget.update();
            setState(() {});
          },
        )
      ],
    );
  }
}
