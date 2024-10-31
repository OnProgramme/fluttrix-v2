import 'dart:async';

import 'package:fluttrix/canvas/models/base/ftrix.event.dart';

class FTrixStream{
  FTrixStream._internal();

  static final FTrixStream _instance = FTrixStream._internal();
  static FTrixStream get instance => _instance;

  static final _streamController = StreamController<FTrixWidgetEvent>.broadcast();

  Stream<FTrixWidgetEvent> get stream => _streamController.stream;

  void addToStream(FTrixWidgetEvent widgetType) {
    _streamController.sink.add(widgetType);
  }

  void dispose() {
    _streamController.close();
  }
}