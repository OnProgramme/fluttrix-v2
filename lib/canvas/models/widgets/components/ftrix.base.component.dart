import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/drop.position.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.drag.target.dart';
import 'package:get/get.dart';

import '../ftrix.image.dart';

class FTrixBaseComponent extends StatefulWidget {
  const FTrixBaseComponent({
    super.key,
    this.setting,
    this.child,
    this.isSelected = false,
    this.onTap,
    required this.widget,
    this.onDrop,
    this.disablePadding = false,
  });

  final FTrixWidgetSetting? setting;
  final Widget? child;
  final bool isSelected;
  final IWidget widget;
  final VoidCallback? onTap;
  final ValueSetter<DroppedWidgetEvent>? onDrop;
  final bool disablePadding;

  @override
  State<FTrixBaseComponent> createState() => _FTrixBaseComponentState();
}

class _FTrixBaseComponentState extends State<FTrixBaseComponent> {
  bool isHovered = false;
  DropPosition dropPosition = DropPosition.NONE;

  bool get isActive => widget.isSelected || isHovered;

  final _key = GlobalKey();

  DropPosition handleGetDropPosition(DragTargetDetails details) {
    final RenderBox renderBox =
        _key.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);
    final localPosition = details.offset - position;

    if (localPosition.dy < size.height / 3) {
      return DropPosition.BEFORE;
    } else if (localPosition.dy > 2 * size.height / 3) {
      return DropPosition.AFTER;
    }
    return DropPosition.INSIDE;
  }

  @override
  Widget build(BuildContext context) {
    final child = ClipRRect(
      borderRadius: widget.setting?.radiusValue ?? BorderRadius.zero,
      child: widget.disablePadding
          ? widget.child
          : Padding(
              padding: widget.setting?.paddingValue ?? EdgeInsets.zero,
              child: widget.child,
            ),
    );

    return FTrixDragTarget(
      onDrop: (details) {
        widget.onDrop?.call(
            DroppedWidgetEvent(handleGetDropPosition(details), details.data));
      },
      child: MouseRegion(
        key: _key,
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          setState(() => isHovered = true);
        },
        onExit: (_) => setState(() => isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            margin: widget.setting?.marginValue,
            duration: Duration(milliseconds: 100),
            decoration: BoxDecoration(
              border:
                  isActive ? Border.all(color: Colors.orange, width: 1) : null,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                if (isActive)
                  Positioned(
                    top: -25,
                    left: -2,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: Text(
                        widget.widget.type.name.toLowerCase().capitalizeFirst!,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                Draggable<IWidget>(
                  data: widget.widget,
                  feedback: child,
                  feedbackOffset: const Offset(0, -25),
                  childWhenDragging: Opacity(opacity: 0.5, child: child),
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
