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
  });
  final Widget? feedback;
  final FTrixToolbarItem item;

  @override
  Widget build(BuildContext context) {
    final widget = Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.background,
            width: 2,
          )
        ),
        width: 85,
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              color: Colors.white,
            ),
            SizedBox(height: 5,),
            Text(
              item.title,
              style: Get.textTheme.bodySmall?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
    return Draggable<WidgetType>(
      data: item.type,
      feedback: feedback ?? widget,
      childWhenDragging: widget,
      child: widget,
    );
  }
}
