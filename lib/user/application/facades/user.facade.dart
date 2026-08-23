import 'package:dartz/dartz.dart';
import 'package:fluttrix/auth/domain/storage/auth.user.storage.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';
import 'package:fluttrix/user/domain/entities/user.entity.dart';
import 'package:fluttrix/user/domain/facades/i.user.facade.dart';
import 'package:fluttrix/user/domain/repo/i.user.repository.dart';

class UserFacade implements IUserFacade{
  final IUserRepository repo;
  final AuthUserStorage storage;
  UserFacade(this.repo, this.storage);

  @override
  Future<Either<AppFailure, User>> getUserByEmail(String email) {
    return repo.getUserByEmail(email).then((response){
      return response.fold((err){
        return Left(err);
      }, (result){
        storage.saveAuthUser(result);
        return Right(result);
      });
    });
  }

  @override
  Future<Either<AppFailure, User>> saveUser(User user) {
    return repo.saveUser(user).then((response){
      return response.fold((err){
        return Left(err);
      }, (result){
        storage.saveAuthUser(result);
        return Right(result);
      });
    });
  }
}