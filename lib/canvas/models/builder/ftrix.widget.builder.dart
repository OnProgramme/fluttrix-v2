import 'package:fluttrix/canvas/models/base/ftrix.container.setting.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.button.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.column.row.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.image.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.scaffold.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.text.setting.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.button.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.column.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.container.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.image.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.listview.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.row.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.scaffold.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.text.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.textfield.dart';

class FTrixWidgetBuilder {
  FTrixWidgetBuilder._();

  static IWidget build(WidgetType type, [String? parentId]) {
    Map<WidgetType, IWidget> widgets = {
      WidgetType.COLUMN: FTrixColumn(
        parentId: parentId,
        setting: FTrixColumnRowSetting.zero,
      ),
      WidgetType.ROW: FTrixRow(
        parentId: parentId,
        setting: FTrixColumnRowSetting.zero,
      ),
      WidgetType.TEXT: FTrixText(
        parentId: parentId,
        setting: FTrixTextSetting.zero,
      ),
      WidgetType.IMAGE: FTrixImage(
        parentId: parentId,
        setting: FTrixImageSetting.zero,
      ),
      WidgetType.INPUT: FTrixTextField(parentId: parentId),
      WidgetType.BUTTON: FTrixButton(
        parentId: parentId,
        setting: FTrixButtonSetting.zero,
      ),
      WidgetType.SCAFFOLD:
          FTrixScaffold(parentId: parentId, setting: FTrixScaffoldSetting.zero),
      WidgetType.LISTVIEW: FTrixListView(parentId: parentId),
      WidgetType.CONTAINER: FTrixContainer(
        parentId: parentId,
        setting: FTrixContainerSetting.zero,
      ),
    };
    final widget = widgets[type];
    if (widget == null) {
      throw Exception('Invalid type');
    }
    return widget;
  }
}
