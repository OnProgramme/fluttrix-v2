import 'package:dartz/dartz.dart';
import 'package:fluttrix/projects/application/usecases/screens/update/udpate.screen.command.dart';
import 'package:fluttrix/projects/domain/repo/screen.repository.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';
import 'package:fluttrix/shared/usecases/usecase.dart';

class UpdateScreenAsync extends UseCaseWithCommand<Unit, UpdateScreenCommand>{
  final ScreenRepository repo;
  UpdateScreenAsync(this.repo);

  @override

  Future<Either<AppFailure, Unit>> execute(UpdateScreenCommand command) {
    return call(repo.updateScreen(command));
  }
}