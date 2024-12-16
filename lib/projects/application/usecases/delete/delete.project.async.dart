import 'package:dartz/dartz.dart';
import 'package:fluttrix/projects/domain/repo/project.repository.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';
import 'package:fluttrix/shared/usecases/usecase.dart';

class DeleteProjectAsync extends UseCaseWithCommand<Unit, String>{
  final ProjectRepository repo;
  DeleteProjectAsync(this.repo);

  @override
  Future<Either<AppFailure, Unit>> execute(String command) {
    return call(repo.delete(command));
  }
}