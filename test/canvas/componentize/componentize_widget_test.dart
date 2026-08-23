import 'package:flutter_test/flutter_test.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/enums/drop.position.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.column.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.component.dart';

void main() {
  group("Componentize widget", () {
    test("un enfant de column devient un FTrixComponent", () async {
      final column = FTrixColumn();
      column.handleDropWidget(DroppedWidgetEvent(DropPosition.AFTER, WidgetType.BUTTON));
      column.handleDropWidget(DroppedWidgetEvent(DropPosition.AFTER, WidgetType.TEXT));

      final child = column.children[0];
      child.componentize(componentId: 'comp-1', componentName: 'MonBouton');
      await Future.delayed(Duration.zero);

      final replaced = column.children[0];
      expect(replaced, isA<FTrixComponent>());
      final component = replaced as FTrixComponent;
      expect(component.componentId, 'comp-1');
      expect(component.componentName, 'MonBouton');
      expect(component.child, isNotNull);
      expect(component.parentId, column.id);
    });

    test("le json du composant sérialise ses métadonnées", () {
      final component = FTrixComponent(
        componentId: 'comp-42',
        componentName: 'MaCarte',
      );
      final json = component.toJson();
      expect(json['type'], WidgetType.COMPONENT.name);
      expect(json['componentId'], 'comp-42');
      expect(json['componentName'], 'MaCarte');
    });

    test("loadFromJson restaure un composant (round-trip)", () {
      final original = FTrixComponent(
        componentId: 'comp-42',
        componentName: 'MaCarte',
      );
      final restored = FTrixComponent();
      restored.loadFromJson(original.toJson());
      expect(restored.componentId, 'comp-42');
      expect(restored.componentName, 'MaCarte');
    });
  });
}
