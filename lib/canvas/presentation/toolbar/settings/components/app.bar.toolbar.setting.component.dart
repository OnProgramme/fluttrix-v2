import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/widgets/appbar/ftrix.app.bar.dart';
import 'package:fluttrix/canvas/models/widgets/appbar/ftrix.app.bar.setting.dart';

class FTrixAppBarToolBarSettingComponent extends StatefulWidget {
  const FTrixAppBarToolBarSettingComponent({super.key, required this.widget});
  final FTrixAppBar widget;

  @override
  State<FTrixAppBarToolBarSettingComponent> createState() =>
      _FTrixAppBarToolBarSettingComponentState();
}

class _FTrixAppBarToolBarSettingComponentState
    extends State<FTrixAppBarToolBarSettingComponent> {
  @override
  Widget build(BuildContext context) {
    final setting = widget.widget.setting as FTrixAppBarSetting;
    return Column(
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          value: setting.centerTitle,
          onChanged: (value) {
            setting.centerTitle = value;
            widget.widget.update();
            setState(() {});
          },
          title: const Text("Center title"),
        ),
      ],
    );
  }
}
