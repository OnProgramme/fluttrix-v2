import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';
import 'package:get/get.dart';


class FtrixImageComponent extends StatelessWidget {
  const FtrixImageComponent({
    super.key,
    required this.src,
    this.setting,
    this.onTap,
    this.isSelected = false,
    required this.onDrop,
    required this.widget,
  });
  final FTrixWidgetSetting? setting;
  final String src;
  final VoidCallback? onTap;
  final bool isSelected;
  final IWidget widget;
  final ValueSetter<DroppedWidgetEvent> onDrop;


  @override
  Widget build(BuildContext context) {
    return FTrixBaseComponent(
      isSelected: isSelected,
      onTap: onTap,
      widget: widget,
      setting: setting,
      onDrop: onDrop,
      child: Image.network(src),
    );
  }
}
