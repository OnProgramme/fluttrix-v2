import 'package:dartz/dartz.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';
import 'package:fluttrix/shared/usecases/usecase.dart';
import 'package:fluttrix/user/domain/entities/user.entity.dart';
import 'package:fluttrix/user/domain/facades/i.user.facade.dart';

class GetProfileAsync extends UseCaseWithCommand<User, String>{
  final IUserFacade facade;
  GetProfileAsync(this.facade);

  @override
  Future<Either<AppFailure, User>> execute(String command) {
    return call(facade.getUserByEmail(command));
  }

}