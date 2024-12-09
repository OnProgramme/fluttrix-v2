import 'package:dartz/dartz.dart';
import 'package:fluttrix/auth/application/usecases/login/login.command.dart';
import 'package:fluttrix/auth/application/usecases/register/register.command.dart';
import 'package:fluttrix/auth/domain/entities/auth.user.entity.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';

abstract class AuthGateway{
  Future<Either<AppFailure, AuthUser>> login(LoginCommand command);
  Future<Either<AppFailure, AuthUser>> register(RegisterCommand command);
}