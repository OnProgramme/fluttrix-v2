import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.image.setting.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';
import 'package:get/get.dart';

class FtrixImageComponent extends StatelessWidget {
  const FtrixImageComponent({
    super.key,
    this.onTap,
    this.isSelected = false,
    required this.src,
    required this.setting,
    required this.onDrop,
    required this.widget,
  });

  final FTrixImageSetting setting;
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
      child: Image.network(
        src,
        fit: BoxFit.cover,
        width: setting.fullWidth ? double.infinity : setting.width,
      ),
    );
  }
}
