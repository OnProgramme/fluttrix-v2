import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.align.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.container.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.button.setting.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.align.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.button.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.container.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.color.picker.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.alignment.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.padding.or.margin.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.radius.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.size.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.textfield.dart';

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
