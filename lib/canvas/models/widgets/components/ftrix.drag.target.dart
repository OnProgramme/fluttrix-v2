import 'package:flutter/material.dart';

class FTrixDragTarget<T extends Object> extends StatefulWidget {
  const FTrixDragTarget({
    super.key,
    required this.child,
    required this.onDrop,
    this.isExpended = false,
  });

  final Widget? child;
  final ValueSetter<DragTargetDetails<T>> onDrop;
  final bool isExpended;

  @override
  State<FTrixDragTarget<T>> createState() => _FTrixDragTargetState<T>();
}

class _FTrixDragTargetState<T extends Object>
    extends State<FTrixDragTarget<T>> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return DragTarget<T>(
      onLeave: (_) => setState(() => isHovering = false),
      onMove: (_) => setState(() => isHovering = true),
      builder: (context, candidateData, rejectedData) {
        return widget.child ?? SizedBox();
      },
      onAcceptWithDetails: (details) {
        widget.onDrop(details);
        setState(() => isHovering = false);
      },
      onWillAcceptWithDetails: (e) => true,
    );
  }
}
