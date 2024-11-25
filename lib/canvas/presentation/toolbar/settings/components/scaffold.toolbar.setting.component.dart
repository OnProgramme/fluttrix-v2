import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.scaffold.setting.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.scaffold.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.color.picker.dart';

class ScaffoldToolBarSettingComponent extends StatefulWidget {
  const ScaffoldToolBarSettingComponent({super.key, required this.widget});
  final FTrixScaffold widget;

  @override
  State<ScaffoldToolBarSettingComponent> createState() =>
      _ScaffoldToolBarSettingComponentState();
}

class _ScaffoldToolBarSettingComponentState
    extends State<ScaffoldToolBarSettingComponent> {
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
