import 'package:fluttrix/shared/events/domain/events/event.dart';
import 'package:fluttrix/user/domain/entities/user.entity.dart';

class UserRegistered extends Event{
  final User user;
  UserRegistered({required this.user});
}