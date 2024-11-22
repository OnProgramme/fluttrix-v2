import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.scaffold.setting.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.app.bar.dart';

class FTrixScaffoldComponent extends StatelessWidget {
  const FTrixScaffoldComponent({
    super.key,
    required this.onDrop,
    this.select,
    this.child,
    required this.setting,
    this.isSelected = false,
    required this.widget,
    required this.appBar,
  });
  final ValueSetter<DroppedWidgetEvent> onDrop;
  final VoidCallback? select;
  final Widget? child;
  final FTrixScaffoldSetting setting;
  final bool isSelected;
  final IWidget widget;
  final FTrixAppBar appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: setting.backgroundColor,
      body: Column(
        children: [
          if (setting.showAppbar) appBar.render(),
          Expanded(
            child: FTrixBaseComponent(
              widget: widget,
              isSelected: isSelected,
              setting: setting,
              onTap: select,
              onDrop: onDrop,
              isDraggable: false,
              child: child ?? Container(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: setting.showBottomNavBar
          ? BottomNavigationBar(items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "",
              ),
            ])
          : null,
    );
  }
}
