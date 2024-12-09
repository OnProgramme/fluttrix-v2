import 'package:fluttrix/shared/events/domain/events/event.dart';
import 'package:fluttrix/shared/events/domain/interfaces/event.listener.dart';

typedef EventHandler<T extends Event> = void Function(T event);

abstract class EventDispatcher {
  void dispatch(String eventName, Event event);
  void subscribe<T extends Event>(String eventName, EventListener listener);
}
