import 'package:fluttrix/canvas/models/base/i.widget.dart';

abstract class FTrixDroppableWidget extends IWidget {
  FTrixDroppableWidget({
    super.parentId,
    required super.type,
    required super.setting,
    super.disableLabel = false,
  });
}
