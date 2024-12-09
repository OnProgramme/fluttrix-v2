import 'package:dartz/dartz.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';
import 'package:fluttrix/user/domain/entities/user.entity.dart';

abstract class IUserFacade{
  Future<Either<AppFailure, User>> saveUser(User user);
  Future<Either<AppFailure, User>> getUserByEmail(String email);
}