import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/drop.position.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.drag.target.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/f.canvas.controller.dart';
import 'package:get/get.dart';

import '../ftrix.image.dart';

class FTrixBaseComponent extends StatefulWidget {
  const FTrixBaseComponent({
    super.key,
    required this.setting,
    this.child,
    this.isSelected = false,
    this.onTap,
    required this.widget,
    this.onDrop,
    this.disablePadding = false,
    this.isDraggable = true,
    this.constraints,
    this.onLongPress,
    this.onLongPressEnd,
    this.disableConstraints = false,
  });

  final FTrixWidgetSetting setting;
  final Widget? child;
  final bool isSelected;
  final IWidget widget;
  final VoidCallback? onTap;
  final ValueSetter<DroppedWidgetEvent>? onDrop;
  final bool disablePadding;
  final bool isDraggable;
  final BoxConstraints? constraints;
  final VoidCallback? onLongPress;
  final ValueSetter<LongPressEndDetails>? onLongPressEnd;
  final bool disableConstraints;
  @override
  State<FTrixBaseComponent> createState() => _FTrixBaseComponentState();
}

class _FTrixBaseComponentState extends State<FTrixBaseComponent> {
  bool isHovered = false;
  DropPosition dropPosition = DropPosition.NONE;
  OverlayEntry? _overlayEntry;

  bool get isActive => widget.isSelected || isHovered;

  final _key = GlobalKey();
  final _childKey = GlobalKey();

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

  void _showOverlay() {
    _removeOverlay();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final renderBox =
          _childKey.currentContext!.findRenderObject() as RenderBox;
      final size = renderBox.size;
      final offset = renderBox.localToGlobal(Offset.zero);

      _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          left: offset.dx,
          top: offset.dy,
          width: size.width,
          height: size.height,
          child: IgnorePointer(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -23,
                  left: 0,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 1.5),
                    child: Text(
                      widget.widget.type.name.toLowerCase().capitalizeFirst!,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange, width: 2),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      Overlay.of(context).insert(_overlayEntry!);
    });
  }


  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final canvasWidth = Get.find<FCanvasController>().canvasSize.value.width;
    final boxConstraint = canvasWidth > 0
        ? BoxConstraints(
            maxWidth: canvasWidth,
          )
        : null;
    final child = ClipRRect(
      borderRadius: widget.setting.radiusValue,
      child: widget.disablePadding
          ? widget.child
          : Container(
              constraints: boxConstraint,
              padding: widget.setting.paddingValue,
              child: widget.child,
            ),
    );
    return FTrixDragTarget(
      isExpended: true,
      onDrop: (details) {
        widget.onDrop?.call(
            DroppedWidgetEvent(handleGetDropPosition(details), details.data));
      },
      child: MouseRegion(
        key: _key,
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          onLongPressEnd: widget.onLongPressEnd,
          child: Container(
            key: _childKey,
            constraints: widget.disableConstraints
                ? null
                : (widget.constraints ?? boxConstraint),
            margin: widget.setting.marginValue,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                widget.isDraggable
                    ? Draggable<IWidget>(
                        data: widget.widget,
                        feedback: child,
                        feedbackOffset: const Offset(0, -25),
                        childWhenDragging: Opacity(opacity: 0.5, child: child),
                        child: child,
                      )
                    : child,
                if (isActive) ...[
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange, width: 2),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -23,
                    left: 0,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 1.5),
                      child: Text(
                        widget.widget.type.name.toLowerCase().capitalizeFirst!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
