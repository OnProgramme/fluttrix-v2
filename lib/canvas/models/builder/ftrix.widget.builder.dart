import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.align.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.button.with.text.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.button.with.child.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.center.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.column.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.container.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.icon.button.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.icon.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.image.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.listview.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.rich.text.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.row.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.scaffold.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.text.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.textfield.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.wrap.dart';

class FTrixWidgetBuilder {
  FTrixWidgetBuilder._();

  static IWidget build(WidgetType type, [String? parentId]) {
    Map<WidgetType, IWidget> widgets = {
      WidgetType.COLUMN: FTrixColumn(parentId: parentId),
      WidgetType.ROW: FTrixRow(parentId: parentId),
      WidgetType.TEXT: FTrixText(parentId: parentId),
      WidgetType.RICH_TEXT: FTrixRichText(parentId: parentId),
      WidgetType.IMAGE: FTrixImage(parentId: parentId),
      WidgetType.INPUT: FTrixTextField(parentId: parentId),
      WidgetType.BUTTON: FTrixButtonWithText(parentId: parentId),
      WidgetType.BUTTON_WITH_CHILD: FTrixButtonWithChild(parentId: parentId),
      WidgetType.SCAFFOLD: FTrixScaffold(parentId: parentId),
      WidgetType.LISTVIEW: FTrixListView(parentId: parentId),
      WidgetType.CONTAINER: FTrixContainer(parentId: parentId),
      WidgetType.ALIGN: FTrixAlign(parentId: parentId),
      WidgetType.CENTER: FTrixCenter(parentId: parentId),
      WidgetType.WRAP: FTrixWrap(parentId: parentId),
      WidgetType.ICON_BUTTON: FTrixIconButton(parentId: parentId),
      WidgetType.ICON: FTrixIcon(parentId: parentId),
    };
    final widget = widgets[type];
    if (widget == null) {
      throw Exception('Invalid type');
    }
    return widget;
  }
}
