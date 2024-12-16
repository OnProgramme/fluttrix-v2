import 'package:dartz/dartz.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';
import 'package:fluttrix/shared/usecases/usecase.dart';
import 'package:fluttrix/user/application/facades/user.facade.dart';
import 'package:fluttrix/user/domain/entities/user.entity.dart';
import 'package:fluttrix/user/domain/facades/i.user.facade.dart';

class SaveUserAsync extends UseCaseWithCommand<User, User>{
  final IUserFacade facade;
  SaveUserAsync(this.facade);

  @override
  Future<Either<AppFailure, User>> execute(User command) {
    return call(facade.saveUser(command));
  }
}