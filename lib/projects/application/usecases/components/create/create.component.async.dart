import 'package:dartz/dartz.dart';
import 'package:fluttrix/projects/application/usecases/components/create/create.component.command.dart';
import 'package:fluttrix/projects/domain/entities/component.entity.dart';
import 'package:fluttrix/projects/domain/repo/component.repository.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';
import 'package:fluttrix/shared/usecases/usecase.dart';

class CreateComponentAsync
    extends UseCaseWithCommand<Component, CreateComponentCommand> {
  final ComponentRepository repo;
  CreateComponentAsync(this.repo);

  @override
  Future<Either<AppFailure, Component>> execute(
      CreateComponentCommand command) {
    final component = Component.create(
      name: command.name,
      projectId: command.projectId,
      data: command.data,
    );
    return call(repo.create(component));
  }
}
