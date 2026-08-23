import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.child.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.container.setting.dart';
import 'package:fluttrix/canvas/models/utils/normalize.json.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';

class FTrixComponent extends FTrixWidgetWithChild {
  String componentId;
  String componentName;

  FTrixComponent({
    super.child,
    super.parentId,
    this.componentId = '',
    this.componentName = 'Composant',
    FTrixContainerSetting? setting,
  }) : super(
          type: WidgetType.COMPONENT,
          setting: setting ?? FTrixContainerSetting.zero,
        );

  @override
  void loadFromJson(Map<String, dynamic> json) {
    super.loadFromJson(json);
    type = WidgetType.COMPONENT;
    componentName = json['componentName'] ?? componentName;
    componentId = json['componentId'] ?? componentId;
    if (json['setting'] != null) {
      setting = FTrixContainerSetting.fromJson(
          normalizeJson(json['setting']));
    }
  }

  @override
  IWidget clone([String? parentId]) {
    final cloneWidget = FTrixComponent(
      componentId: componentId,
      componentName: componentName,
      parentId: parentId ?? this.parentId,
      setting: FTrixContainerSetting.fromJson(setting.toJson()),
    );
    return cloneWidget..child = child?.clone(cloneWidget.id);
  }

  @override
  Widget render() {
    final setting = this.setting as FTrixContainerSetting;
    return FTrixBaseComponent(
      onDrop: handleDropWidget,
      widget: this,
      setting: setting,
      isSelected: isWidgetSelected,
      onTap: select,
      label: componentName,
      child: child?.render(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "componentId": componentId,
        "componentName": componentName,
      });
  }
}
