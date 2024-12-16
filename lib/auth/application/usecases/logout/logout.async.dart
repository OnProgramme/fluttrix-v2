import 'package:dartz/dartz.dart';
import 'package:fluttrix/auth/domain/facades/i.auth.facade.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';
import 'package:fluttrix/shared/usecases/usecase.dart';

class LogoutAsync extends UseCaseWithoutCommand<Unit>{
  final IAuthFacade _facade;
  LogoutAsync(this._facade);

  @override
  Future<Either<AppFailure, Unit>> execute() {
    return call(_facade.logout());
  }
}