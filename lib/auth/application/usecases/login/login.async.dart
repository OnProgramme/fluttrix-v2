import 'package:dartz/dartz.dart';
import 'package:fluttrix/auth/application/usecases/login/login.command.dart';
import 'package:fluttrix/auth/domain/entities/auth.user.entity.dart';
import 'package:fluttrix/auth/domain/facades/i.auth.facade.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';
import 'package:fluttrix/shared/usecases/usecase.dart';

class LoginAsync extends UseCase<AuthUser, LoginCommand>{
  final IAuthFacade _facade;
  LoginAsync(this._facade);
  @override
  Future<Either<AppFailure, AuthUser>> execute(LoginCommand command) {
    return call(_facade.login(command));
  }
}