import 'package:flutter_test/flutter_test.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/enums/drop.position.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.column.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.container.dart';

void main(){
  group("Test can add child or children to widget", (){

    test('Test can add widget child to column widget', (){
      final column = FTrixColumn();
      column.handleDropWidget(DroppedWidgetEvent(
          DropPosition.AFTER,
          WidgetType.CONTAINER
      ));
      expect(column.children.length, 1);
      expect(column.children[0].type, WidgetType.CONTAINER);
    });

    test('Test can add widget child to container widget', (){
      final container = FTrixContainer();
      container.handleDropWidget(DroppedWidgetEvent(
          DropPosition.INSIDE,
          WidgetType.CONTAINER
      ));
      expect(container.child?.type, WidgetType.CONTAINER);
    });

  });
}