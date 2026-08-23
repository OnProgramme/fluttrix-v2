import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.child.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/utils/normalize.json.dart';
import 'package:fluttrix/canvas/models/widgets/appbar/ftrix.app.bar.setting.dart';
import 'package:fluttrix/canvas/models/widgets/builder/ftrix.build.widget.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.container.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.text.dart';

import '../../enums/widget.type.dart';

class FTrixAppBar extends FTrixWidgetWithChild {
  List<IWidget> actions;
  IWidget? leading;
  FTrixAppBar(
      {IWidget? child,
      super.parentId,
      super.disableLabel,
      List<IWidget>? actions})
      : actions = actions ?? [],
        super(
          type: WidgetType.APPBAR,
          setting: FTrixAppBarSetting.zero,
          child: child ?? FTrixText(text: 'Home page'),
        );

  @override
  void loadFromJson(Map<String, dynamic> json) {
    setting = FTrixAppBarSetting.fromJson(normalizeJson(json['setting']));
    FTrixBuildWidget.build(child!, normalizeJson(json));
    // actions = List<IWidget>.from(json['actions'].map((x) => FTrixWidget.loadFromJson(x)));
  }

  @override
  IWidget clone([String? parentId]) {
    return FTrixAppBar();
  }

  @override
  Widget render() {
    final setting = this.setting as FTrixAppBarSetting;
    return FTrixBaseComponent(
      setting: setting,
      widget: this,
      isDraggable: false,
      onTap: select,
      child: AppBar(
        centerTitle: setting.centerTitle,
        backgroundColor: setting.backgroundColor,
        title: FTrixContainer(
          disableLabel: true,
          child: child,
        ).render(),
        actions: actions.map((action) {
          return action.render();
        }).toList(),
      ),
    );
  }
}
