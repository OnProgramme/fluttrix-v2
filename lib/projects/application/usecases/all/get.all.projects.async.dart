import 'package:dartz/dartz.dart';
import 'package:fluttrix/projects/domain/entities/project.entity.dart';
import 'package:fluttrix/projects/domain/repo/project.repository.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';
import 'package:fluttrix/shared/usecases/usecase.dart';

class GetAllProjectsAsync extends UseCaseWithCommand<List<Project>, String>{
  final ProjectRepository repo;
  GetAllProjectsAsync(this.repo);
  @override
  Future<Either<AppFailure, List<Project>>> execute(String command) {
    return call(repo.getProjects(command));
  }
}