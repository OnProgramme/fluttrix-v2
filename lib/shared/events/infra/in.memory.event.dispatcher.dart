import 'package:fluttrix/shared/events/domain/events/event.dart';
import 'package:fluttrix/shared/events/domain/interfaces/event.dispatcher.dart';
import 'package:fluttrix/shared/events/domain/interfaces/event.listener.dart';

class InMemoryEventDispatcher implements EventDispatcher{
  final Map<String, List<EventHandler<Event>>> _listeners = {};

  @override
  void dispatch(String eventName, Event event) {
    if (_listeners.containsKey(eventName)) {
      for (final callback in _listeners[eventName]!) {
        callback(event);
      }
    }
  }

  @override
  void subscribe<T extends Event>(String eventName, EventListener listener) {
    _listeners.putIfAbsent(eventName, () => []).add((event){
      _listeners.putIfAbsent(eventName, () => []).add((event) {
        if (event is T) {
          listener.handle(event);
        }
      });
    });
  }
}