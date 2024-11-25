import 'dart:async';

import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.stream.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';

abstract class FTrixDroppableWidget extends IWidget {
  FTrixDroppableWidget({super.parentId, required super.type, required super.setting});
  void handleDropWidget(DroppedWidgetEvent event);
}
