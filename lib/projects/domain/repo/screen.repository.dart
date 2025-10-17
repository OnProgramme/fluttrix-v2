import 'package:dartz/dartz.dart';
import 'package:fluttrix/projects/application/usecases/screens/update/udpate.screen.command.dart';
import 'package:fluttrix/projects/domain/entities/screen.entity.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';

abstract class ScreenRepository{
  Future<Either<AppFailure, List<Screen>>> getScreens(String projectId);
  Future<Either<AppFailure, Screen>> create(Screen screen);
  Future<Either<AppFailure, Unit>> delete(String screenId);
  Future<Either<AppFailure, Unit>> deleteAll(String projectId);
  Future<Either<AppFailure, Unit>> updateScreen(UpdateScreenCommand command);
}