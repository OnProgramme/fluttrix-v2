import 'package:flutter_test/flutter_test.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/enums/drop.position.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.column.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.container.dart';

void main(){
  group("Test can wrap widget on other widget", (){
    test("Test can wrap widget content in column with parent", ()async{
      final column = FTrixColumn();
      column.handleDropWidget(DroppedWidgetEvent(DropPosition.AFTER, WidgetType.BUTTON));
      column.handleDropWidget(DroppedWidgetEvent(DropPosition.AFTER, WidgetType.IMAGE));
      final child1 = column.children[0];
      child1.wrapParent(WidgetType.CONTAINER);
      await Future.delayed(Duration.zero);
      final newChild1 = column.children[0];
      expect(newChild1.type, WidgetType.CONTAINER);
    });

    test("Test can wrap widget content in container with parent", ()async{
      final container = FTrixContainer();
      container.handleDropWidget(DroppedWidgetEvent(DropPosition.INSIDE, WidgetType.IMAGE));
      container.child!.wrapParent(WidgetType.ALIGN);
      await Future.delayed(Duration.zero);
      expect(container.child?.type, WidgetType.ALIGN);
    });
  });
}