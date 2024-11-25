import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.textfield.setting.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';

class FtrixTextFieldComponent extends StatefulWidget {
  const FtrixTextFieldComponent({
    super.key,
    this.onTap,
    this.isSelected = false,
    required this.setting,
    required this.onDrop,
    required this.widget,
  });
  final FTrixTextFieldSetting setting;
  final VoidCallback? onTap;
  final bool isSelected;
  final IWidget widget;
  final ValueSetter<DroppedWidgetEvent> onDrop;

  @override
  State<FtrixTextFieldComponent> createState() =>
      _FtrixTextFieldComponentState();
}

class _FtrixTextFieldComponentState extends State<FtrixTextFieldComponent> {
  FTrixTextFieldSetting get setting => widget.setting;

  bool obscureText = false;
  bool isLongPressed = false;

  @override
  void initState() {
    super.initState();
    obscureText = setting.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return FTrixBaseComponent(
      isSelected: widget.isSelected,
      widget: widget.widget,
      setting: widget.setting,
      onDrop: widget.onDrop,
      // onLongPress: () {
      //   setState(() {
      //     isLongPressed = true;
      //   });
      // },
      // onLongPressEnd: (details) {
      //   setState(() {
      //     isLongPressed = false;
      //   });
      // },
      child: TextFormField(
        onTap: widget.onTap,
        enabled: !isLongPressed,
        obscureText: setting.isPassword,
        decoration: InputDecoration(
          labelText: setting.label,
          hintText: setting.hint,
          suffixIcon: setting.isPassword
              ? IconButton(
                  iconSize: 20,
                  onPressed: () => setState(() {
                        obscureText = !obscureText;
                      }),
                  icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility))
              : null,
          border: setting.isUnderlinedBorder
              ? UnderlineInputBorder()
              : OutlineInputBorder(
                  borderRadius: setting.radiusValue,
                ),
        ),
      ),
    );
  }
}
