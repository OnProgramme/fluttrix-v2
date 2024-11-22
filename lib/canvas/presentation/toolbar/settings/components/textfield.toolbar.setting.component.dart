import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.textfield.setting.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.textfield.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.padding.or.margin.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.radius.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.textfield.dart';

class TextFieldToolBarSettingComponent extends StatefulWidget {
  const TextFieldToolBarSettingComponent({super.key, required this.widget});
  final FTrixTextField widget;

  @override
  State<TextFieldToolBarSettingComponent> createState() =>
      _TextFieldToolBarSettingComponentState();
}

class _TextFieldToolBarSettingComponentState
    extends State<TextFieldToolBarSettingComponent> {
  late FTrixTextFieldSetting setting;
  final labelController = TextEditingController();
  final hintController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setting = widget.widget.setting as FTrixTextFieldSetting;
    initController();
  }

  @override
  void didUpdateWidget(covariant TextFieldToolBarSettingComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    setting = widget.widget.setting as FTrixTextFieldSetting;
    initController();
  }

  @override
  Widget build(BuildContext context) {
    final setting = widget.widget.setting as FTrixTextFieldSetting;
    return Column(
      key: ValueKey(widget.widget.id),
      children: [
        FTextField(
          label: "Label",
          initialValue: setting.label,
          onChanged: (value) {
            setting.label = value;
            widget.widget.update();
          },
        ),
        SizedBox(
          height: 10,
        ),
        FTextField(
          label: "Placeholder",
          initialValue: setting.hint,
          onChanged: (value) {
            setting.hint = value;
            widget.widget.update();
          },
        ),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          value: setting.isPassword,
          title: Text("Mot de passe"),
          onChanged: (value) {
            setting.isPassword = value!;
            widget.widget.update();
            setState(() {});
          },
        ),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          value: setting.isUnderlinedBorder,
          title: Text("Underline border"),
          onChanged: (value) {
            setting.isUnderlinedBorder = value!;
            widget.widget.update();
            setState(() {});
          },
        ),
        FTrixEditPaddingOrMargin(
          isMargin: true,
          setting: setting.margin,
          onUpdated: () => widget.widget.update(),
        ),
        SizedBox(
          height: 10,
        ),
        FTrixEditRadius(
          setting: setting.radius,
          onUpdated: () => widget.widget.update(),
        ),
        SizedBox(
          height: 10,
        ),
        FTrixEditPaddingOrMargin(
          setting: setting.padding,
          onUpdated: () => widget.widget.update(),
        ),
      ],
    );
  }

  void initController() {
    labelController.text = setting.label ?? '';
    hintController.text = setting.hint ?? '';
  }
}
