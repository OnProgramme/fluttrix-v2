import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';

class FTrixListViewComponent extends StatelessWidget {
  const FTrixListViewComponent({
    super.key,
    this.isSelected = false,
    this.onTap,
    this.setting,
    required this.children,
    required this.widget,
    this.onDrop,
  });
  final bool isSelected;
  final VoidCallback? onTap;
  final FTrixWidgetSetting? setting;
  final List<Widget> children;
  final IWidget widget;
  final ValueSetter<dynamic>? onDrop;

  @override
  Widget build(BuildContext context) {
    return FTrixBaseComponent(
      onDrop: onDrop,
      isSelected: isSelected,
      onTap: onTap,
      widget: widget,
      setting: setting,
      child: ListView(
        children: children,
      ),
    );
  }
}
