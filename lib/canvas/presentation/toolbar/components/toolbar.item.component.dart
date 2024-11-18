import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/toolbar/ftrix.toolbar.item.dart';

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
      child: SizedBox(
        width: 150,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon),
            Text(item.title),
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
