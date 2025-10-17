import 'dart:async';

import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/events/ftrix.delete.widget.event.data.dart';
import 'package:fluttrix/canvas/models/events/ftrix.drop.widget.event.data.dart';
import 'package:fluttrix/canvas/models/events/ftrix.select.widget.event.data.dart';
import 'package:fluttrix/canvas/models/events/ftrix.wrap.parent.event.data.dart';

class FirstEventTransformer<T> extends StreamTransformerBase<T, T> {
  final Duration cooldownDuration;

  FirstEventTransformer(this.cooldownDuration);

  @override
  Stream<T> bind(Stream<T> stream) {
    final controller = StreamController<T>();
    bool isCooldownActive = false;

    stream.listen(
          (event) {
        if (!isCooldownActive) {
          // Émet immédiatement le premier événement
          controller.add(event);
          isCooldownActive = true;

          // Lance un timer pour sortir du mode "cooldown"
          Timer(cooldownDuration, () {
            isCooldownActive = false;
          });
        }
      },
      onDone: controller.close,
      onError: controller.addError,
    );

    return controller.stream;
  }
}

class FTrixStream {
  FTrixStream._internal();

  static final FTrixStream _instance = FTrixStream._internal();
  static FTrixStream get instance => _instance;

  static final _streamController =
      StreamController<FTrixWidgetEvent>.broadcast();
  static final _streamControllerEvent =
      StreamController<FTrixEventData>.broadcast();

  Stream<FTrixEventData> get streamEvent => _streamControllerEvent.stream;


  void addToStream(FTrixWidgetEvent widgetType) {
    _streamController.sink.add(widgetType);
  }

  void addToStreamEvent(FTrixEventData event) {
    _streamControllerEvent.sink.add(event);
  }

  Stream<FTrixSelectWidgetEventData> get selectWidgetEvent =>
      instance.streamEvent
          .where((e) => e.type == FTrixWidgetEventType.SELECT || e.type == FTrixWidgetEventType.UNSELECT)
          .map((e) => e as FTrixSelectWidgetEventData);


  Stream<FTrixWrapParentEventData> get wrapParentWidgetEvent =>
      instance.streamEvent
          .where((e) => e.type == FTrixWidgetEventType.WRAP_PARENT)
          .map((e) => e as FTrixWrapParentEventData);

  Stream<FTrixDeleteWidgetEventData> get deleteWidgetEvent =>
      instance.streamEvent
          .where((e) => e.type == FTrixWidgetEventType.DELETE)
          .map((e) => e as FTrixDeleteWidgetEventData);

  Stream<FTrixDropWidgetEventData> get dropWidgetEvent =>
      instance.streamEvent
          .where((e) => e.type == FTrixWidgetEventType.DROP)
          .map((e) => e as FTrixDropWidgetEventData);

  Stream<FTrixEventData> get updateCanvas =>
      instance.streamEvent
          .where((e) {
            return e.type == FTrixWidgetEventType.UPDATE || e.type == FTrixWidgetEventType.DELETE;
          });


  void dispose() {
    _streamController.close();
  }
}
