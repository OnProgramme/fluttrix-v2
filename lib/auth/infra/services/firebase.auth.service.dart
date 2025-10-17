import 'package:dartz/dartz.dart';
import 'package:fluttrix/auth/application/usecases/login/login.command.dart';
import 'package:fluttrix/auth/application/usecases/register/register.command.dart';
import 'package:fluttrix/auth/domain/entities/auth.user.entity.dart';
import 'package:fluttrix/auth/domain/events/user.logged.dart';
import 'package:fluttrix/auth/domain/events/user.registered.dart';
import 'package:fluttrix/auth/domain/services/auth.gateway.dart';
import 'package:fluttrix/shared/events/domain/events/event.name.dart';
import 'package:fluttrix/shared/events/domain/interfaces/event.dispatcher.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:fluttrix/utils/app.dependencies.dart';

import '../../../user/domain/entities/user.entity.dart';

class FirebaseAuthService implements AuthGateway {
  final _eventDispatch = AppDependencies.get<EventDispatcher>();

  @override
  Future<Either<AppFailure, AuthUser>> login(LoginCommand command) async {
    try {
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: command.email,
        password: command.password,

      );
      final user = AuthUser(email: response.user!.email!);
      _eventDispatch.dispatch(EventName.login, UserLogged(email: user.email));
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AppFailure.emailOrPasswordInvalid());
    } catch(e){
      return Left(AppFailure.internetConnection());
    }
  }

  @override
  Future<Either<AppFailure, AuthUser>> register(RegisterCommand command) async{
    try {
      final response = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: command.email,
        password: command.password,
      );
      final user = AuthUser(email: response.user!.email!);
      _eventDispatch.dispatch(EventName.register, UserRegistered(user: User.create(email: user.email)));
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AppFailure.emailOrPasswordInvalid());
    } catch(e){
      return Left(AppFailure.internetConnection());
    }
  }

  @override
  Future<Either<AppFailure, Unit>> logout() async{
    await FirebaseAuth.instance.signOut();
    return Right(unit);
  }
}
