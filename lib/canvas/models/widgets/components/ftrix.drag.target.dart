import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';

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
    return Stack(
      fit: widget.isExpended ? StackFit.expand : StackFit.loose,
      children: [
        if (isHovering)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text("Déposez-ici")],
            ),
          ),
        DragTarget<T>(
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
        ),
      ],
    );
  }
}
