import 'package:dartz/dartz.dart';
import 'package:fluttrix/auth/application/usecases/register/register.command.dart';
import 'package:fluttrix/auth/domain/entities/auth.user.entity.dart';
import 'package:fluttrix/auth/domain/facades/i.auth.facade.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';
import 'package:fluttrix/shared/usecases/usecase.dart';

class RegisterAsync extends UseCaseWithCommand<AuthUser, RegisterCommand>{
  final IAuthFacade _facade;
  RegisterAsync(this._facade);
  @override
  Future<Either<AppFailure, AuthUser>> execute(RegisterCommand command) {
    return call(_facade.register(command));
  }
}