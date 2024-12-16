import 'package:dartz/dartz.dart';
import 'package:fluttrix/projects/application/usecases/create/create.project.command.dart';
import 'package:fluttrix/projects/domain/entities/project.entity.dart';
import 'package:fluttrix/projects/domain/repo/project.repository.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';
import 'package:fluttrix/shared/usecases/usecase.dart';

class CreateProjectAsync extends UseCaseWithCommand<Project, CreateProjectCommand>{
  final ProjectRepository repo;
  CreateProjectAsync(this.repo);

  @override
  Future<Either<AppFailure, Project>> execute(CreateProjectCommand command) {
    final project = Project.create(userId: command.userId, projectName: command.projectName);
    return call(repo.create(project));
  }

}