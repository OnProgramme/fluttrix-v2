import 'package:fluttrix/auth/domain/events/user.logged.dart';
import 'package:fluttrix/auth/domain/storage/auth.user.storage.dart';
import 'package:fluttrix/shared/events/domain/interfaces/event.listener.dart';
import 'package:fluttrix/shared/usecases/usecase.dart';
import 'package:fluttrix/user/domain/entities/user.entity.dart';

class GetUserToFirestoreAfterLoginListener extends EventListener<UserLogged> {
  final UseCaseWithCommand<User, String> useCase;
  final AuthUserStorage storage;
  GetUserToFirestoreAfterLoginListener({
    required this.useCase,
    required this.storage,
  });

  @override
  void handle(UserLogged event) {
    useCase.execute(event.email);
  }
}
