import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/utils/debouncer.dart';
import 'package:fluttrix/utils/app.colors.dart';

enum _ResizeDirection { top, bottom, left, right }

class FTrixResizableWidgetComponent extends StatefulWidget {
  final Widget child;
  final bool enableHorizontalResize;
  final bool enableVerticalResize;
  final double minWidth;
  final double minHeight;
  final double maxWidth;
  final double maxHeight;
  final bool disabled;
  final ValueSetter<Size>? onResized;

  const FTrixResizableWidgetComponent({
    super.key,
    required this.child,
    this.enableHorizontalResize = true,
    this.enableVerticalResize = true,
    this.minWidth = 50.0,
    this.minHeight = 50.0,
    this.maxWidth = double.infinity,
    this.maxHeight = double.infinity,
    this.disabled = false,
    this.onResized,
  });

  @override
  _FTrixResizableWidgetComponentState createState() =>
      _FTrixResizableWidgetComponentState();
}

class _FTrixResizableWidgetComponentState
    extends State<FTrixResizableWidgetComponent> {
  final debouncer = ResizeDebouncer(delay: Duration(milliseconds: 100));
  double _width = 0;
  double _height = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateIntrinsicSize();
    });
  }

  void _updateSize(DragUpdateDetails details, bool isHorizontal,
      _ResizeDirection handlePosition) {
    if (isHorizontal && widget.enableHorizontalResize) {
      if (handlePosition == _ResizeDirection.left) {
        _width =
            (_width - details.delta.dx).clamp(widget.minWidth, widget.maxWidth);
      } else if (handlePosition == _ResizeDirection.right) {
        _width =
            (_width + details.delta.dx).clamp(widget.minWidth, widget.maxWidth);
      }
      debouncer.run(() => widget.onResized?.call(Size(_width, _height)));
    }

    if (!isHorizontal && widget.enableVerticalResize) {
      if (handlePosition == _ResizeDirection.top) {
        _height = (_height - details.delta.dy)
            .clamp(widget.minHeight, widget.maxHeight);
      } else if (handlePosition == _ResizeDirection.bottom) {
        _height = (_height + details.delta.dy)
            .clamp(widget.minHeight, widget.maxHeight);
      }
      debouncer.run(() => widget.onResized?.call(Size(_width, _height)));
    }
    setState(() {});
  }

  void _calculateIntrinsicSize() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;

    if (renderBox != null) {
      final Size childSize = _getChildSize();
      _width = childSize.width.clamp(widget.minWidth, widget.maxWidth);
      _height = childSize.height.clamp(widget.minHeight, widget.maxHeight);
    }
  }

  Size _getChildSize() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.hasSize) {
      return renderBox.size;
    }

    return Size(widget.minWidth, widget.minHeight);
  }

  @override
  void dispose() {
    super.dispose();
    debouncer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.disabled) {
      return widget.child;
    }
    return SizedBox(
      width: _width > 0 ? _width : null,
      height: _height > 0 ? _height : null,
      child: Stack(
        children: [
          widget.child,
          if (widget.enableHorizontalResize) ...[
            // Left resize handle
            // Positioned(
            //   left: 0,
            //   top: 0,
            //   bottom: 0,
            //   child: GestureDetector(
            //     onHorizontalDragUpdate: (details) =>
            //         _updateSize(details, true, _ResizeDirection.left),
            //     child: MouseRegion(
            //       cursor: SystemMouseCursors.resizeColumn,
            //       child: Container(
            //         width: 10,
            //         color: Colors.transparent,
            //         alignment: Alignment.centerLeft,
            //         child: Container(
            //           height: 30,
            //           width: 5,
            //           decoration: BoxDecoration(
            //               color: AppColors.selectColor,
            //               borderRadius: BorderRadius.circular(5)),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Right resize handle
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) =>
                    _updateSize(details, true, _ResizeDirection.right),
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeColumn,
                  child: Container(
                    width: 10,
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 30,
                      width: 5,
                      decoration: BoxDecoration(
                          color: AppColors.selectColor,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
            ),
          ],

          // Vertical resize handles
          if (widget.enableVerticalResize) ...[
            // Top resize handle
            // Positioned(
            //   left: 0,
            //   right: 0,
            //   top: 0,
            //   child: GestureDetector(
            //     onVerticalDragUpdate: (details) =>
            //         _updateSize(details, false, _ResizeDirection.top),
            //     child: MouseRegion(
            //       cursor: SystemMouseCursors.resizeRow,
            //       child: Container(
            //         height: 10,
            //         color: Colors.transparent,
            //         alignment: Alignment.topCenter,
            //         child: Container(
            //           width: 30,
            //           height: 5,
            //           decoration: BoxDecoration(
            //               color: AppColors.selectColor,
            //               borderRadius: BorderRadius.circular(5)),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Bottom resize handle
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onVerticalDragUpdate: (details) =>
                    _updateSize(details, false, _ResizeDirection.bottom),
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeRow,
                  child: Container(
                    height: 10,
                    color: Colors.transparent,
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 30,
                      height: 5,
                      decoration: BoxDecoration(
                          color: AppColors.selectColor,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
