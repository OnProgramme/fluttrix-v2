import 'package:dartz/dartz.dart';
import 'package:fluttrix/projects/application/usecases/screens/create/create.screen.command.dart';
import 'package:fluttrix/projects/domain/entities/screen.entity.dart';
import 'package:fluttrix/projects/domain/repo/screen.repository.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';
import 'package:fluttrix/shared/usecases/usecase.dart';

class CreateScreenAsync extends UseCaseWithCommand<Screen, CreateScreenCommand> {
  final ScreenRepository repo;
  CreateScreenAsync(this.repo);

  @override
  Future<Either<AppFailure, Screen>> execute(CreateScreenCommand command) {
    final screen = Screen.create(
      name: command.name,
      projectId: command.projectId,
      data: command.screenData,
    );
    return call(repo.create(screen));
  }
}