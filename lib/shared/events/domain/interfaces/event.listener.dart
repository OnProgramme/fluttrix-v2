import 'package:fluttrix/shared/events/domain/events/event.dart';

abstract class EventListener<T extends Event>{
 void handle(T event);
}