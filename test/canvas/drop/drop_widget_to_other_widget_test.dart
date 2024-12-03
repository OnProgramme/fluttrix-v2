import 'package:flutter_test/flutter_test.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.child.dart';
import 'package:fluttrix/canvas/models/enums/drop.position.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.align.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.button.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.column.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.container.dart';

void main(){
  group("Test can drop widget to other widget", (){

    test('Test can drop widget to column widget', ()async{
      final column = FTrixColumn();
      column.handleDropWidget(DroppedWidgetEvent(DropPosition.AFTER, WidgetType.CONTAINER));
      await Future.delayed(Duration.zero);
      expect(column.children.length, 1);
      expect(column.children[0].type, WidgetType.CONTAINER);
    });

    test('Test can drop widget to container widget', ()async{
      final container = FTrixContainer();
      container.handleDropWidget(DroppedWidgetEvent(DropPosition.INSIDE, WidgetType.CONTAINER));
      expect(container.child?.type, WidgetType.CONTAINER);
    });


    test("Test can drop existing widget and change position to column", ()async{
      final column = FTrixColumn();
      column.handleDropWidget(DroppedWidgetEvent(DropPosition.AFTER, WidgetType.IMAGE));
      column.handleDropWidget(DroppedWidgetEvent(DropPosition.AFTER, WidgetType.CONTAINER));
      column.handleDropWidget(DroppedWidgetEvent(DropPosition.AFTER, WidgetType.COLUMN));
      column.handleDropWidget(DroppedWidgetEvent(DropPosition.AFTER,FTrixContainer(
          child: FTrixButton()
      )));
      await Future.delayed(Duration.zero);
      final firstChildren = column.children.first;
      final lastChildren = column.children.last as FTrixWidgetWithChild;
      firstChildren.handleDropWidget(DroppedWidgetEvent(DropPosition.BEFORE, lastChildren.child));
      await Future.delayed(Duration.zero);
      expect(column.children.first.type, WidgetType.BUTTON);
      expect(lastChildren.child, null);
    });

  });
}