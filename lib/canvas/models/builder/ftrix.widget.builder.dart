import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.button.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.column.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.image.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.listview.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.row.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.scaffold.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.text.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.textfield.dart';

class FTrixWidgetBuilder{
  FTrixWidgetBuilder._();

  static build(WidgetType type){
    Map<WidgetType, IWidget> widgets = {
      WidgetType.COLUMN: FTrixColumn(),
      WidgetType.ROW: FTrixRow(),
      WidgetType.TEXT: FTrixText(),
      WidgetType.IMAGE: FTrixImage(),
      WidgetType.INPUT: FTrixTextField(),
      WidgetType.BUTTON: FTrixButton(),
      WidgetType.SCAFFOLD: FTrixScaffold(),
      WidgetType.LISTVIEW: FTrixListView(),
    };
    return widgets[type];
  }
}