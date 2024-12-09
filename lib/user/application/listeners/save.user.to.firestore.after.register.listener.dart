import 'package:fluttrix/auth/domain/events/user.registered.dart';
import 'package:fluttrix/auth/domain/storage/auth.user.storage.dart';
import 'package:fluttrix/shared/events/domain/interfaces/event.listener.dart';
import 'package:fluttrix/shared/usecases/usecase.dart';
import 'package:fluttrix/user/domain/entities/user.entity.dart';

class SaveUserToFirestoreAfterRegisterListener
    extends EventListener<UserRegistered> {
  final UseCase<User, User> useCase;
  final AuthUserStorage storage;
  SaveUserToFirestoreAfterRegisterListener({
    required this.storage,
    required this.useCase,
  });

  @override
  void handle(UserRegistered event) {
    useCase.execute(event.user);
  }
}
