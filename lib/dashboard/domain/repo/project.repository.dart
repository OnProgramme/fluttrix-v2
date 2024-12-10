import 'package:dartz/dartz.dart';
import 'package:fluttrix/dashboard/application/usecases/create/create.project.command.dart';
import 'package:fluttrix/dashboard/domain/entities/project.entity.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';

abstract class ProjectRepository{
  Future<Either<AppFailure, List<Project>>> getProjects(String userId);
  Future<Either<AppFailure, Project>> create(Project project);
}