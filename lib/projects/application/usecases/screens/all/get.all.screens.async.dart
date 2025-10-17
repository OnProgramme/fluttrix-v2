import 'package:dartz/dartz.dart';
import 'package:fluttrix/projects/domain/entities/screen.entity.dart';
import 'package:fluttrix/projects/domain/repo/screen.repository.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';
import 'package:fluttrix/shared/usecases/usecase.dart';

class GetAllScreensAsync extends UseCaseWithCommand<List<Screen>, String>{
  final ScreenRepository repo;
  GetAllScreensAsync(this.repo);

  @override
  Future<Either<AppFailure, List<Screen>>> execute(String command) {
    return call(repo.getScreens(command));
  }
}