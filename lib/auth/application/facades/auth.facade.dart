import 'package:dartz/dartz.dart';
import 'package:fluttrix/auth/application/usecases/login/login.command.dart';
import 'package:fluttrix/auth/application/usecases/register/register.command.dart';
import 'package:fluttrix/auth/domain/entities/auth.user.entity.dart';
import 'package:fluttrix/auth/domain/facades/i.auth.facade.dart';
import 'package:fluttrix/auth/domain/services/auth.gateway.dart';
import 'package:fluttrix/auth/domain/storage/auth.user.storage.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';

class AuthFacade implements IAuthFacade{
  final AuthGateway _gateway;
  final AuthUserStorage _userStorage;
  AuthFacade(this._gateway, this._userStorage);

  @override
  Future<Either<AppFailure, AuthUser>> login(LoginCommand command) async{
   return _gateway.login(command);
  }

  @override
  Future<Either<AppFailure, AuthUser>> register(RegisterCommand command) {
    return _gateway.register(command);
  }

  @override
  Future<Either<AppFailure, Unit>> logout() async{
    await _userStorage.clear();
    return _gateway.logout();
  }
}