import 'package:dartz/dartz.dart';
import 'package:fluttrix/projects/application/usecases/screens/delete_all/delete.all.screens.command.dart';
import 'package:fluttrix/projects/domain/repo/screen.repository.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';
import 'package:fluttrix/shared/usecases/usecase.dart';

class DeleteAllScreensAsync extends UseCaseWithCommand<Unit, DeleteAllScreensCommand>{
  final ScreenRepository repo;
  DeleteAllScreensAsync(this.repo);

  @override
  Future<Either<AppFailure, Unit>> execute(DeleteAllScreensCommand command) {
    return call(repo.deleteAll(command.projectId));
  }
}