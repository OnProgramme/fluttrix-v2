import 'package:fluttrix/shared/events/domain/events/event.dart';

class UserLogged extends Event{
  final String email;
  UserLogged({required this.email});
}