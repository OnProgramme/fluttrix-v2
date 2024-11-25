import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.container.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.button.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.scaffold.setting.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.button.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.container.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.scaffold.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.color.picker.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.padding.or.margin.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.radius.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.size.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.textfield.dart';

class ScaffoldToolBarSettingComponent extends StatefulWidget {
  const ScaffoldToolBarSettingComponent({super.key, required this.widget});
  final FTrixScaffold widget;

  @override
  State<ScaffoldToolBarSettingComponent> createState() => _ScaffoldToolBarSettingComponentState();
}

class _ScaffoldToolBarSettingComponentState extends State<ScaffoldToolBarSettingComponent> {
  @override
  Widget build(BuildContext context) {
    final setting = widget.widget.setting as FTrixScaffoldSetting;
    return Column(
      children: [
        FTrixColorPicker(
          label: "Background Color",
          initialColor: setting.backgroundColor,
          onChanged: (color) {
            setting.backgroundColor = color;
            print(setting.backgroundColor);
            widget.widget.update();
          },
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          value: setting.showAppbar,
          onChanged: (value) {
            setting.showAppbar = value;
            widget.widget.update();
            setState(() {});
          },
          title: const Text("Show Appbar"),
        ),
      ],
    );
  }
}
