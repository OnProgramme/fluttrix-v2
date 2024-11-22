import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.listview.setting.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';

class FTrixListViewComponent extends StatelessWidget {
  const FTrixListViewComponent({
    super.key,
    this.isSelected = false,
    this.onTap,
    required this.setting,
    required this.children,
    required this.widget,
    this.onDrop,
  });
  final bool isSelected;
  final VoidCallback? onTap;
  final FTrixListViewSetting setting;
  final List<Widget> children;
  final IWidget widget;
  final ValueSetter<DroppedWidgetEvent>? onDrop;

  @override
  Widget build(BuildContext context) {
    return FTrixBaseComponent(
      onDrop: onDrop,
      isSelected: isSelected,
      disablePadding: true,
      onTap: onTap,
      widget: widget,
      setting: setting,
      child: ListView(
        scrollDirection: setting.scrollDirection,
        padding: setting.paddingValue,
        children: children,
      ),
    );
  }
}
