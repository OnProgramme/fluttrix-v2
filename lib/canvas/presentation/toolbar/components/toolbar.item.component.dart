import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/toolbar/ftrix.toolbar.item.dart';
import 'package:fluttrix/utils/app.colors.dart';
import 'package:get/get.dart';

class ToolbarItemComponent extends StatelessWidget {
  const ToolbarItemComponent({
    super.key,
    this.feedback,
    required this.item,
    this.disableDraggable = false,
    this.onTap,
  });
  final Widget? feedback;
  final FTrixToolbarItem item;
  final bool disableDraggable;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final widget = Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          color: AppColors.background,
          width: 2,
        )),
        width: 85,
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              color: Colors.white,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              item.title,
              style: Get.textTheme.bodySmall?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
    if (disableDraggable) {
      return InkWell(
        onTap: onTap,
        child: widget,
      );
    }
    return Draggable<WidgetType>(
      data: item.type,
      feedback: feedback ?? widget,
      childWhenDragging: widget,
      child: widget,
    );
  }
}
