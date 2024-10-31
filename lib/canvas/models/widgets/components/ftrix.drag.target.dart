import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';

class FTrixDragTarget extends StatelessWidget {
  const FTrixDragTarget({
    super.key,
    required this.child,
    required this.onDrop,
  });

  final Widget? child;
  final ValueSetter<WidgetType> onDrop;

  @override
  Widget build(BuildContext context) {
    return DragTarget<WidgetType>(

      builder: (context, candidateData, rejectedData) {
        return child??SizedBox();
      },
      onAcceptWithDetails: (details) => onDrop(details.data),
      onWillAcceptWithDetails: (e) => true,
    );
  }
}
